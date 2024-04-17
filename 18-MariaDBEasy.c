///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  18-MariaDB.c  -o 18-MariaDB.bc
// Created by nsas2020 on 24-3-18.
//https://github.com/MariaDB/server/pull/1952/commits
//https://github.com/MariaDB/server/pull/1951
//MariaDB 服务器在 ARM (弱内存模型架构) 上崩溃，
// 这是在并发执行
// l_find 以加载 node->key 和 add_to_purgatory 以存储 node->key = NULL 时发生的。
// l_find 然后使用 key（此时为 NULL），将其传递给比较函数。
//具体问题是在弱内存模型架构上发生的乱序执行。有两种可能的重排序需要被阻止。
//
//a) 由于 l_find 在乐观读取 key 字段 lf_hash.cc#L117 与验证链接 lf_hash.cc#L124 之间没有设置屏障，
// 处理器可以重新排序加载操作在 while 循环之后发生。
//
//在这种情况下，一个并发线程执行相同节点上的 add_to_purgatory 可以被调度在 key 被加载到 l_find 之前将 key 字段 lf_alloc-pin.c#L253 存储为 NULL。


#include <stdio.h>
#include <stdlib.h>
#include <stdatomic.h>
#include <pthread.h>
#include <string.h>
#include <stdint.h>

typedef unsigned int uint32;
typedef unsigned char uchar;    /* Short for unsigned char */
typedef unsigned long intptr;

/*
  the last bit in LF_SLIST::link is a "deleted" flag.
  the helper macros below convert it to a pure pointer or a pure flag
*/
#define PTR(V)      (LF_SLIST *)((V) & (~(intptr)1))


typedef struct LF_SLIST {
    intptr link;   /* a pointer to the next element in a list and a flag */
    uint32 hashnr;         // 节点的哈希值
    const uchar *key;      // 指向节点键的指针
    size_t keylen;         // 键的长度
} LF_SLIST;

typedef struct {
    LF_SLIST **prev; // 指向前一个节点的指针
    LF_SLIST *curr;  // 当前节点
    LF_SLIST *next;  // 下一个节点
} CURSOR;

#define LF_PINBOX_PINS 4
#define CPU_LEVEL1_DCACHE_LINESIZE 64
#define LF_DYNARRAY_LEVELS       4

typedef void lf_pinbox_free_func(void *, void *, void *);


typedef struct {
    void *volatile level[LF_DYNARRAY_LEVELS];
    uint size_of_element;
} LF_DYNARRAY;

typedef struct {
    LF_DYNARRAY pinarray;
    lf_pinbox_free_func *free_func;
    void *free_func_arg;
    uint free_ptr_offset;
    uint32 volatile pinstack_top_ver;         /* this is a versioned pointer */
    uint32 volatile pins_in_array;            /* number of elements in array */
} LF_PINBOX;

typedef struct {
    void *volatile pin[LF_PINBOX_PINS];
    LF_PINBOX *pinbox;
    void *purgatory;
    uint32 purgatory_count;
    uint32 volatile link;
    /* avoid false sharing */
    char pad[CPU_LEVEL1_DCACHE_LINESIZE];
} LF_PINS;


#define compile_time_assert(X)                                  \
  do                                                            \
  {                                                             \
    typedef char compile_time_assert[(X) ? 1 : -1] __attribute__((unused)); \
  } while(0)
#define my_atomic_storeptr(P, D) __atomic_store_n((P), (D), __ATOMIC_SEQ_CST)


/* compile-time assert to make sure we have enough pins.  */
#define lf_pin(PINS, PIN, ADDR)                                \
  do {                                                          \
    compile_time_assert(PIN < LF_PINBOX_PINS);                  \
    my_atomic_storeptr(&(PINS)->pin[PIN], (ADDR));              \
  } while(0)
#define my_atomic_casptr(P, E, D) \
  __atomic_compare_exchange_n((P), (E), (D), 0, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)


static int l_find(LF_SLIST **head, const uchar *key, size_t keylen, CURSOR *cursor, LF_PINS *pins) {
    uint32 cur_hashnr;
    const uchar *cur_key;
    size_t cur_keylen;
    intptr link;

    for (;;) {
        if (!cursor->curr)
            return 0; // 链表尾部

        cur_hashnr = cursor->curr->hashnr;
        cur_keylen = cursor->curr->keylen;

        // 乐观地读取 key，此处是并发访问的关键部分
        cur_key = cursor->curr->key;

        // 遍历下一个节点，考虑内存对齐和并发安全
        do {
            link = cursor->curr->link;
            cursor->next = PTR(link);

            // 使用 lf_pin 对下一个节点进行 "固定" 操作，避免并发删除
            lf_pin(pins, 0, cursor->next);
        } while (link != cursor->curr->link); // 检查 link 是否在读取期间被修改，确保并发一致性

        // 这里可以添加对 cur_key 的处理逻辑，例如与传入的 key 进行比较

        cursor->curr = cursor->next;
        lf_pin(pins, 1, cursor->curr);
    }
}


#define add_to_purgatory(PINS, ADDR)                                    \
  do                                                                    \
  {                                                                     \
    *(void **)((char *)(ADDR)+(PINS)->pinbox->free_ptr_offset)=         \
      (PINS)->purgatory;                                                \
    (PINS)->purgatory= (ADDR);                                          \
    (PINS)->purgatory_count++;                                          \
  } while (0)

#define LF_PURGATORY_SIZE 100


void lf_pinbox_real_free(LF_PINS* pins) {
    // Assuming purgatory is a singly-linked list of nodes to be freed.
    void * current = pins->purgatory;
    void *next;

    while (current != NULL) {
        next = current->next; // Save next node.
        free(current); // Free the current node.
        current = next; // Move to next node.
    }

    // After freeing, reset the purgatory list and count.
    pins->purgatory = NULL;
    pins->purgatory_count = 0;
}


static int l_delete(LF_SLIST **head, const uchar * *cs, uint32 hashnr,
                    const uchar *key, uint keylen, LF_PINS *pins) {
    CURSOR cursor;
    int res;

    for (;;) {
        if (!l_find(head, key, keylen, &cursor, pins)) {
            res = 1; // not found
            break;
        } else {
            // Ensure pointer is correctly cast to integer before compare-and-swap (CAS) and setting delete mark
            void *expected = cursor.next;
            void *newValue = (void *)((intptr_t)cursor.next | 1);
            if (my_atomic_casptr(&(cursor.curr->link), &expected, newValue)) {
                // Attempt physical deletion from the list
                if (my_atomic_casptr(cursor.prev, &cursor.curr, cursor.next)) {
                    add_to_purgatory(pins, cursor.curr); // Assuming addr is equivalent to cursor.curr
                    // Check if cleanup needs to be performed
                    if (pins->purgatory_count % LF_PURGATORY_SIZE == 0)
                        lf_pinbox_real_free(pins);
                }
                res = 0; // Successfully deleted
                break;
            }
        }
    }
    return res;
}
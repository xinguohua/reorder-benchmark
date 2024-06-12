// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c -std=c11 22-openmpi.c  -o 22-openmpi.bc
// Created by nsas2020 on 24-3-18. (52, 75) (55, 68)  /usr/local/clang-4.0/bin/clang -S -emit-llvm -g -c -std=c11 22-openmpi.c -o 22-openmpi.ll
// https://github.com/open-mpi/ompi/pull/771/files
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h> // 为了使用sleep函数

#define PUSH_OPERATIONS 1
#define POP_OPERATIONS 1


// 模拟 OPAL 库中的原子操作和数据结构，实际使用时需要引入相应的库
typedef struct opal_list_item_t {
    struct opal_list_item_t* opal_list_next;
    atomic_int item_free;
} opal_list_item_t;

typedef struct {
    _Atomic(opal_list_item_t*) item;
} opal_atomic_lifo_head_t;

typedef struct {
    opal_atomic_lifo_head_t opal_lifo_head;
    opal_list_item_t opal_lifo_ghost; // 用作哨兵节点
} opal_lifo_t;

opal_list_item_t* item;
// 原子写内存屏障
void opal_atomic_wmb() {
    // 实际实现需要根据平台进行内存屏障操作
}

// 添加元素到 LIFO
opal_list_item_t* opal_lifo_push_atomic(opal_lifo_t* lifo) {
    item->item_free = 1;
    do {
        opal_list_item_t* next = lifo->opal_lifo_head.item;
        item->opal_list_next = next;
        opal_atomic_wmb();
        if (atomic_compare_exchange_strong(&lifo->opal_lifo_head.item, &next, item)) {
            opal_atomic_wmb();
            /* now safe to pop this item */
            item->item_free = 0;
            printf("1");
            return next;
        }
        // 在此处实现暂停以释放总线，具体实现取决于平台
    } while (1);
}

// 从 LIFO 取出元素
opal_list_item_t* opal_lifo_pop_atomic(opal_lifo_t* lifo) {
    while ((item = lifo->opal_lifo_head.item) != &lifo->opal_lifo_ghost) {
        /* ensure it is safe to pop the head */
        if (item->item_free ==1) {
            continue;
        }
        printf("3");

        // opal_atomic_wmb ();
        /* ensure it is safe to pop the head */
        if (atomic_compare_exchange_weak(&lifo->opal_lifo_head.item, &item, item->opal_list_next)) {
            break;
        }
        item ->item_free = 0;
    }
    return NULL;
}


// 示例使用和测试代码
opal_lifo_t lifo;

// 推入操作线程函数
void* push_thread_func(void* arg) {
    for (int i = 0; i < PUSH_OPERATIONS; ++i) {
        opal_lifo_push_atomic(&lifo);
    }
    return NULL;
}

// 弹出操作线程函数
void* pop_thread_func(void* arg) {
    for (int i = 0; i < POP_OPERATIONS; ++i) {
        opal_list_item_t* item = opal_lifo_pop_atomic(&lifo);
    }
    return NULL;
}

void opal_lifo_init() {
    // 初始化幽灵节点。在实际的库中，可能需要更复杂的初始化。
    lifo.opal_lifo_ghost.item_free = 0; // 假设item_free = 0表示节点未被使用
    lifo.opal_lifo_ghost.opal_list_next = NULL; // 幽灵节点没有下一个节点
    item = malloc(sizeof(opal_list_item_t));

    // 设置LIFO的头部指向幽灵节点。这表示LIFO开始时为空。
    lifo.opal_lifo_head.item = &lifo.opal_lifo_ghost;
}


int main() {
    pthread_t push_thread, pop_thread;

    // 初始化LIFO
    opal_lifo_init();

    // 创建推入和弹出操作的线程
    if (pthread_create(&push_thread, NULL, push_thread_func, NULL) != 0) {
        perror("Failed to create push thread");
        return 1;
    }
    sleep(1);
    if (pthread_create(&pop_thread, NULL, pop_thread_func, NULL) != 0) {
        perror("Failed to create pop thread");
        return 1;
    }

    // 等待线程完成
    pthread_join(push_thread, NULL);
    pthread_join(pop_thread, NULL);

    // 验证最终LIFO的状态是否符合预期（例如，是否为空）

    return 0;
}

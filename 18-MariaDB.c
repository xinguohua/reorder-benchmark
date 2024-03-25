///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  18-MariaDB.c  -o 18-MariaDB.bc
// Created by nsas2020 on 24-3-18.
//https://github.com/MariaDB/server/pull/1952/commits
//https://github.com/MariaDB/server/pull/1951
//


#include <stdio.h>
#include <stdlib.h>
#include <stdatomic.h>
#include <pthread.h>
#include <string.h>
#include <stdint.h>

typedef struct LF_SLIST {
    atomic_intptr_t link;
    const char *key;
} LF_SLIST;

typedef struct {
    LF_SLIST **head;
    const char *search_key;
} find_args;

atomic_intptr_t head = ATOMIC_VAR_INIT((intptr_t) NULL);

typedef struct {
    intptr_t *prev;
    LF_SLIST *curr;
    LF_SLIST *next;
} CURSOR;

#define PTR(V)      (LF_SLIST*)((intptr_t)(V) & ~(intptr_t)1)
#define DELETED(V)  (((intptr_t)(V)) & 1)


void add_to_purgatory(LF_SLIST *node) {
    intptr_t old_link;
    do {
        old_link = atomic_load(&node->link);
        printf("333");
    } while (!atomic_compare_exchange_weak(&node->link, &old_link, old_link | 1));
    printf("3444");
    node->key = NULL;
}

// 假设性的 lf_pin 函数定义
void lf_pin(void *pins, int mode, LF_SLIST *node) {
    // 这里应该是一些关于内存管理的逻辑
}

int l_find(LF_SLIST **head, CURSOR *cursor, void *pins, int (*callback)(LF_SLIST *, void *)) {
    const char *cur_key;
    intptr_t link;
    cursor->prev = (intptr_t *) head;
    cursor->curr = cursor->prev;

    cur_key = cursor->curr->key;
    printf("111");

    do {
        lf_pin(pins, 1, cursor->curr);
        do {
            link = atomic_load(&cursor->curr->link);
            cursor->next = PTR(link);
            if (cursor->next) {
                lf_pin(pins, 0, cursor->next);
            }
            printf("2222");

        } while (link != atomic_load(&cursor->curr->link));

        if (!DELETED(link) && cursor->curr->key != NULL) {
            if (callback && cur_key) {
                if (callback(cursor->curr, (void *) cur_key)) return 1;
            }
        }
        cursor->prev = &cursor->curr->link;
        cursor->curr = cursor->next;
    } while (cursor->curr != NULL);

    return 0;
}

// 为了适配 l_find 的调用，需要适当调整这个函数
void *thread_func_find(void *arg) {
    find_args *f_args = (find_args *) arg;
    CURSOR cursor;
    // 这里需要提供一个符合 l_find 要求的 callback 函数，以及 pins 参数
    // 由于代码中没有给出具体的 pins 和 callback 实现，这里留空
    l_find(f_args->head, &cursor, NULL, NULL);
    return NULL;
}

void *thread_func_purgatory(void *arg) {
    add_to_purgatory((LF_SLIST *) arg);
    return NULL;
}

int main() {
    LF_SLIST node1 = {.link = ATOMIC_VAR_INIT((intptr_t) NULL), .key = "key1"};
    atomic_store(&head, (intptr_t) &node1);

    find_args args = {.head = (LF_SLIST **) &head, .search_key = "key1"};

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_func_find, &args);
    pthread_create(&t2, NULL, thread_func_purgatory, &node1);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    return 0;
}

///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  18-MariaDB.c  -o 18-MariaDB.bc
// Created by nsas2020 on 24-3-18.
//https://github.com/MariaDB/server/pull/1952/commits
//https://github.com/MariaDB/server/pull/1951
// 30:46


#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdatomic.h>
#include <unistd.h>

typedef struct Node {
    atomic_intptr_t key;
    struct Node *next;
    atomic_intptr_t link;
} Node;

Node head;

int compare(intptr_t key1, intptr_t key2) {
    return key1 == key2;
}

Node *l_find(Node *head, intptr_t key) {
    Node *node = head;
    while (node != NULL) {
        // 乐观读取 key 字段（可能会被重排序）
        intptr_t nodeKey = atomic_load(&node->key);  // lf_hash.cc#L117

        // 验证链接
        if (atomic_load(&node->link) != 0) {  // lf_hash.cc#L124
            // 如果链接有效，比较 key
            if (compare(nodeKey, key)) {
                return node;
            }
        }
        node = node->next;
    }
    return NULL;
}

void add_to_purgatory(Node *node) {
    // 在没有适当的屏障情况下，存储操作可能会被重排序到前面
    atomic_store(&node->key, 0);  // lf_alloc-pin.c#L253
}


void *thread_find(void *arg) {
    intptr_t key = 1;
    l_find(&head, key);
    return NULL;
}

void *thread_purgatory(void *arg) {
    add_to_purgatory(&head);
    return NULL;
}

int main() {
    intptr_t key1 = 1;
    Node head;
    atomic_init(&head.key, key1);
    head.next = NULL;
    atomic_init(&head.link, 0);

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_find, NULL);
    pthread_create(&t2, NULL, thread_purgatory, NULL);

    sleep(1);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    return 0;
}

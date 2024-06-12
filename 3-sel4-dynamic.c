// 81:52  60:83
// Created by nsas2020 on 24-3-15.
// https://github.com/seL4/seL4/pull/199/commits/8ba22dcdc5fa667b41db6eb80b434 21a84868398
// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  3-sel4.c -o 3-sel4.bc
#include <stdatomic.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>

// CLH节点
typedef struct clh_node {
    _Atomic bool locked;
} clh_node_t;

// CLH锁
typedef struct clh_lock {
    _Atomic(clh_node_t*) tail;
    pthread_key_t my_node_key;
} clh_lock_t;

// 初始化CLH锁
void clh_lock_init(clh_lock_t* lock) {
    clh_node_t* dummy = (clh_node_t*)malloc(sizeof(clh_node_t));
    atomic_store(&dummy->locked, false);
    atomic_store(&lock->tail, dummy);
    pthread_key_create(&lock->my_node_key, free);
}

// 销毁CLH锁
void clh_lock_destroy(clh_lock_t* lock) {
    free(atomic_load(&lock->tail));
    pthread_key_delete(lock->my_node_key);
}

// 获取CLH锁
void clh_lock(clh_lock_t* lock) {
    clh_node_t* my_node = (clh_node_t*)malloc(sizeof(clh_node_t));
    atomic_store(&my_node->locked, true);
    pthread_setspecific(lock->my_node_key, my_node);

    clh_node_t* pred = atomic_exchange_explicit(&lock->tail, my_node, memory_order_acquire);

    while (atomic_load(&pred->locked)) {
        // 自旋等待
    }
}

// 释放CLH锁
void clh_unlock(clh_lock_t* lock) {
    clh_node_t* my_node = (clh_node_t*)pthread_getspecific(lock->my_node_key);
    atomic_store(&my_node->locked, false);
}

void* thread_func(void* arg) {
    clh_lock_t* lock = (clh_lock_t*)arg;
    clh_lock(lock);
    printf("Thread %lu acquired the lock\n", pthread_self());
    clh_unlock(lock);
    printf("Thread %lu released the lock\n", pthread_self());
    return NULL;
}

int main() {
    clh_lock_t lock;
    clh_lock_init(&lock);

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_func, &lock);
    pthread_create(&t2, NULL, thread_func, &lock);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    clh_lock_destroy(&lock);
    return 0;
}
// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  17-ceph.c  -o 17-ceph.bc
// Created by nsas2020 on 24-3-17. (26:35) (26:34)
//https://github.com/ceph/ceph/pull/38765


#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <assert.h>
#include <unistd.h>

typedef struct {
    pthread_mutex_t mutex;
    unsigned int nlock;
    pthread_t locked_by;
    int recursive;
} CustomLock;

void custom_lock_init(CustomLock *lock, int recursive) {
    lock->nlock = 0;
    lock->locked_by = 0;
    lock->recursive = recursive;
}

int is_locked_by_me(const CustomLock *lock) {
    if(lock-> nlock > 0){
        assert(lock->locked_by == pthread_self());
    }
    return lock->nlock > 0 && lock->locked_by == pthread_self();
    //return nlock.load(std::memory_order_acquire) > 0 && locked_by == std::this_thread::get_id();
}

void _post_lock(CustomLock *lock) {
    if (!lock->recursive)
        assert(lock->nlock == 0);

    lock->locked_by = pthread_self();
    lock->nlock++;
}

// 专门调用 _post_lock 的线程函数
void* lock_thread(void* arg) {
    CustomLock *lock = (CustomLock*)arg;
    _post_lock(lock);
    printf("Lock acquired in lock_thread.\n");
    return NULL;
}

// 专门调用 is_locked_by_me 的线程函数
void* check_lock_thread(void* arg) {
    CustomLock *lock = (CustomLock*)arg;
    if (is_locked_by_me(lock)) {
        printf("Lock is held by check_lock_thread, which should not happen.\n");
    } else {
        printf("Lock is not held by check_lock_thread.\n");
    }
    return NULL;
}

int main() {
    pthread_t t1, t2;
    CustomLock lock = {0, 0, 0}; // 初始化锁

    // 创建一个线程用于尝试锁定
    if(pthread_create(&t1, NULL, lock_thread, &lock)) {
        fprintf(stderr, "Error creating lock_thread\n");
        return 1;
    }



    // 创建另一个线程用于检查锁状态
    if(pthread_create(&t2, NULL, check_lock_thread, &lock)) {
        fprintf(stderr, "Error creating check_lock_thread\n");
        return 1;
    }

    // 等待第一个线程完成，确保锁已经被获取
    pthread_join(t1, NULL);
    // 等待第二个线程完成
    pthread_join(t2, NULL);

    return 0;
}

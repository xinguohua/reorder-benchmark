// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c 24-mysql.c  -o 24-mysql.bc (21, 65)
// Created by nsas2020 on 24-3-18.  /usr/local/clang-4.0/bin/clang -S -emit-llvm -g -c -std=c11 24-mysql.c -o 24-mysql.ll
// https://bugs.mysql.com/bug.php?id=87293

#include <stdatomic.h>
#include <stdio.h>
#include <stdbool.h>
#include <pthread.h>

// 定义互斥锁的状态
#define MUTEX_STATE_UNLOCKED 0
#define MUTEX_STATE_LOCKED 1
#define MUTEX_STATE_WAITERS 2

// 声明一个原子类型的锁变量
_Atomic int m_lock_word = MUTEX_STATE_UNLOCKED;

// 尝试获取锁
bool try_lock() {
    int expected = MUTEX_STATE_UNLOCKED;
    return atomic_compare_exchange_strong(&m_lock_word, &expected, MUTEX_STATE_LOCKED);
}


int TAS(_Atomic int *lock_word, int new_val) {
    // 直接返回操作前的值
    return atomic_exchange(lock_word, new_val);
}


int unlock() {
    return TAS(&m_lock_word, MUTEX_STATE_UNLOCKED);
}


// 获取锁
void enter() {
    if (!try_lock()) {
        // 在真实情况下，这里可能需要一些延时或其他逻辑来防止忙等待
    }
}

// 模拟的os_rmb函数
void os_rmb() {
    // 实现细节省略，通常是一个内存屏障操作
}

int state() {
    return atomic_load(&m_lock_word);
}

// 模拟唤醒等待的线程
void signal() {
    // 实现细节省略，这里可以根据具体需求实现
    // 例如，使用条件变量通知等待线程
}


void myExit() {
    // 读内存屏障，确保操作顺序
    os_rmb();
    // wmb

    if (state() == MUTEX_STATE_WAITERS) {
        m_lock_word = MUTEX_STATE_UNLOCKED;
    } else if (unlock() == MUTEX_STATE_LOCKED) {
        // 如果没有线程在等待，就没有必要唤醒
        return;
    }

    // 唤醒等待的线程
    signal();
}

// 工作函数，由每个线程执行
void* worker(void* arg) {
    enter();
    printf("Thread %ld: Mutex acquired.\n", (long)arg);
    myExit();
    // 模拟一些工作
    printf("Thread %ld: Mutex released.\n", (long)arg);
    return NULL;
}

int main() {
    const int NUM_THREADS = 2;
    pthread_t threads[NUM_THREADS];

    for (long i = 0; i < NUM_THREADS; i++) {
        pthread_create(&threads[i], NULL, worker, (void*)i);
    }

    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

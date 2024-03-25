// 81:52  60:83
// Created by nsas2020 on 24-3-15.
// https://github.com/seL4/seL4/pull/199/commits/8ba22dcdc5fa667b41db6eb80b434 21a84868398
// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  3-sel4.c -o 3-sel4.bc
#include <stdatomic.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

typedef enum {
    CLHState_Granted = 0,
    CLHState_Pending
} clh_qnode_state_t;


typedef struct clh_qnode {
    _Atomic(clh_qnode_state_t) value;
    struct clh_qnode* next;
} clh_qnode_t;

#define MAX_CPUS 256

typedef struct {
    _Atomic(clh_qnode_t*) heads[MAX_CPUS]; // 为每个CPU单独设置一个头节点
    clh_qnode_t* node_owners[MAX_CPUS]; // 每个CPU的锁节点所有者
} big_kernel_lock_t;

big_kernel_lock_t big_kernel_lock; // 全局锁实例



// 锁的初始化函数
void clh_lock_init() {
    for (int i = 0; i < MAX_CPUS; ++i) {
        big_kernel_lock.node_owners[i] = malloc(sizeof(clh_qnode_t));
        big_kernel_lock.node_owners[i]-> next = NULL;
        atomic_store(&big_kernel_lock.node_owners[i]->value, CLHState_Granted);
    }
    for (int i = 0; i < MAX_CPUS; ++i) {
        big_kernel_lock.heads[i] = malloc(sizeof(clh_qnode_t));
        big_kernel_lock.heads[i]-> next = NULL;
        atomic_store(&big_kernel_lock.heads[i]->value, CLHState_Granted);
    }
}


static inline void clh_lock_acquire(int cpu) {
    // 将当前节点状态设置为等待
    clh_qnode_t *prev;
    printf("cpu%d --1 W value", cpu);
    big_kernel_lock.node_owners[cpu]->value = CLHState_Pending;

    // 原子地插入当前节点到队列尾部，并获取之前的尾节点
    // 此操作同时设置了当前节点为新的队列尾部
    prev = atomic_exchange_explicit(&big_kernel_lock.heads[cpu], big_kernel_lock.node_owners[cpu], memory_order_acquire);
    // right
   // prev = atomic_exchange_explicit(&big_kernel_lock.heads[cpu], big_kernel_lock.node_owners[cpu], memory_order_acq_rel);
    printf("cpu%d --2 W next", cpu);
    big_kernel_lock.node_owners[cpu]->next = prev;

    // 循环等待前一个节点释放锁，即其状态变为已授予
    // 这是一个忙等待，可能需要一种机制来减少CPU的消耗，如轻量级的暂停或睡眠
    while (big_kernel_lock.node_owners[cpu]->next->value != CLHState_Granted) {
        // 在这里，根据具体平台和需求，可能会调用特定于架构的暂停指令，如x86上的`_mm_pause()`
        // 为了简化，这里不包含这些调用
    }

    // 当前节点现在持有锁，可以安全进入临界区
    // 注意，实际进入临界区的代码应该紧随此函数调用之后
    atomic_thread_fence(memory_order_acquire);

}

void clh_lock_release(int cpu) {
    // 确保所有临界区的操作都在此内存栅栏之前完成
    atomic_thread_fence(memory_order_release);

    // 将节点的状态设置为已授予，让下一个等待的线程可以获取锁
    printf("cpu%d --3 W value", cpu);
    big_kernel_lock.node_owners[cpu]->value = CLHState_Granted;
    printf("cpu%d --4 W next", cpu);
    big_kernel_lock.node_owners[cpu] = big_kernel_lock.node_owners[cpu]->next;
}


void* thread_func(void *arg) {
    int cpu = *((int *) arg);

    printf("CPU %d has acquired the lock.\n", cpu);

    clh_lock_acquire(cpu);

    // 模拟执行临界区代码
    int sleep_time = 2; // Generate random sleep time between 1 and 5 seconds
    sleep(sleep_time); // Sleep for random time

    clh_lock_release(cpu);
    printf("CPU %d has released the lock.\n", cpu);

    return NULL;
}

int main() {
    int num_cpus = 5; // 假设有4个CPU核心
    pthread_t threads[num_cpus];

    clh_lock_init();

    for (int i = 0; i < num_cpus; i++) {
        for (int j=0; j< 3; j++){
            pthread_create(&threads[i], NULL, thread_func, &i);
        }

    }

    for (int i = 0; i < num_cpus; i++) {
        for (int j=0; j< 3; j++) {
            pthread_join(threads[i], NULL);
        }
    }

    return 0;
}
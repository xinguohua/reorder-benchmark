//原来的代码
//[54]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64d816cba06c
//改进的代码
//[19]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95bcade33a8a
//Linux内核代码 下载4.5
//https://blog.csdn.net/wtl1992/article/details/121739072
//queued_spin_lock_slowpath::node 382
///usr/local/clang-4.0/bin/clang -emit-llvm -g -c 1-Linuxeasy.c  -o 1-Linuxeasy.bc
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <pthread.h>
#include <time.h>
#include <unistd.h>

typedef struct mcs_node {
    atomic_bool locked;
    struct mcs_node* next;
} mcs_node_t;

typedef struct {
    _Atomic(mcs_node_t*) tail;
} qspinlock_t;

void qspinlock_init(qspinlock_t* lock) {
    lock->tail = NULL;
}

//void qspin_lock(qspinlock_t* lock, mcs_node_t* mynode) {
//    mynode->next = NULL;
//    atomic_store_explicit(&mynode->locked, true, memory_order_relaxed);
//
//    mcs_node_t* prev = atomic_exchange_explicit(&lock->tail, mynode, memory_order_acq_rel);
//    if (prev != NULL) {
//        prev->next = mynode;
//        _Atomic(bool) flag =  atomic_load_explicit(&mynode->locked, memory_order_acquire);
//        while (flag) {
//            // Busy-wait
//            flag = atomic_load_explicit(&mynode->locked, memory_order_acquire);
//        }
//    }
//}

// 有问题的
void qspin_lock(qspinlock_t* lock, mcs_node_t* mynode, int i) {
    mynode->next = NULL;
    mynode->locked = true;
    printf("1W locked  %d\n", i);
    mcs_node_t* prev = lock->tail; //
    lock->tail = mynode;
    if (prev != NULL) {
        prev->next = mynode;
        // 1,2 may order
        printf("2W next  %d\n", i);
        while (mynode->locked) {
            // Busy-wait
        }
    }
}

void qspin_unlock(qspinlock_t* lock, mcs_node_t* mynode, int i) {
    printf("3R next   %d\n", i);
    if (!mynode->next) {
        if (atomic_compare_exchange_strong_explicit(&lock->tail, &mynode, NULL, memory_order_release, memory_order_relaxed)) {
            return;
        }
        while (!mynode->next) {
            // Wait for the successor to appear
        }
    }
    printf("4W locked   %d\n", i);
    atomic_store_explicit(&mynode->next->locked, false, memory_order_release);
}


#define NUM_THREADS 8 // 定义线程数量

qspinlock_t my_lock;


void *thread_function(void *arg) {
    int thread_id = *((int*)arg); // 获取传递过来的线程 ID
    mcs_node_t* my_node = (mcs_node_t*)malloc(sizeof(mcs_node_t)); // Allocate a new node for each thread
    printf("Thread started %d\n", thread_id); // 打印线程启动信息
    qspin_lock(&my_lock, my_node, thread_id);

    // Critical section
    int sleep_time = rand() % 5 + 1; // Generate random sleep time between 1 and 5 seconds
    sleep(sleep_time); // Sleep for random time

    qspin_unlock(&my_lock, my_node, thread_id);
    printf("Thread finished %d\n", thread_id); // 打印线程结束信息

    return NULL;
}
int main() {
    // Initialize the lock
    qspinlock_init(&my_lock);

    // Create threads
    pthread_t threads[NUM_THREADS];
    int i;
    for (i = 0; i < NUM_THREADS; i++) {
        pthread_create(&threads[i], NULL, thread_function, (void*)&i);
    }

    // Wait for threads to finish
    for (i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

//原来的代码
//[54]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64d816cba06c
//改进的代码
//[19]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95bcade33a8a
//Linux内核代码 下载4.5
//https://blog.csdn.net/wtl1992/article/details/121739072
//queued_spin_lock_slowpath::node 382
///usr/local/clang-4.0/bin/clang -emit-llvm -g -c 1-Linuxeasy.c  -o 1-Linuxeasy.bc (47, 72) (52, 63)
// clang -emit-llvm -S -o 1-Linuxeasy.ll 1-Linuxeasy.c
// time nidhugg --no-spin-assume  -arm 1-Linuxeasy.ll
// cbmc --arch arm64 --mm pso --unwind 1000  1-Linuxeasy.c
#include <pthread.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <unistd.h>
#include <assert.h>


typedef struct mcs_node {
    atomic_bool locked;
    struct mcs_node* next;
} mcs_node_t;

typedef struct {
    _Atomic(mcs_node_t*) tail;
} qspinlock_t;

#define NUM_THREADS 8 // 定义线程数量
//mcs_node_t nodes[NUM_THREADS]; // 全局数组，存储每个线程的 mcs_node_t 实例
mcs_node_t global_node;
qspinlock_t my_lock;

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
    mcs_node_t* prev = lock->tail; //
    lock->tail = mynode;
    if (prev != NULL) {
        prev->next = mynode;

        // 1,2 may order
        int timeout = 10000; // 例如，设置为一百万次迭代
        while (mynode->locked) {
            // Busy-wait

            if (timeout-- >= 0) {
                assert(true); // 断言失败，表示超时
            }
        }
    }
}

void qspin_unlock(qspinlock_t* lock, mcs_node_t* mynode, int i) {
    if (!mynode->next) {
        if (lock->tail == mynode) {
            lock->tail = NULL;
            return;
        }
        while (!mynode->next) {
            // Wait for the successor to appear
        }
    }
    __atomic_thread_fence(__ATOMIC_RELEASE);
    mynode->next->locked = false;
}


void* enter_critical_section(void* arg) {
    int thread_id = *((int*)arg);
    qspin_lock(&my_lock, &global_node, thread_id);
    // Critical section start
    return NULL;
}

void* exit_critical_section(void* arg) {
    int thread_id = *((int*)arg);

    // Critical section end
    //int sleep_time = 10 % 5 + 1; // Generate random sleep time between 1 and 5 seconds
    //sleep(sleep_time); // Sleep for random time

    qspin_unlock(&my_lock, &global_node, thread_id);
    return NULL;
}

int main() {
    // Initialize the lock
    qspinlock_init(&my_lock);
    pthread_t thread1, thread2;
    int thread_id = 1;
    // Create threads
    pthread_create(&thread1, NULL, enter_critical_section, &thread_id);
    pthread_create(&thread2, NULL, exit_critical_section, &thread_id);


    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    return 0;
}

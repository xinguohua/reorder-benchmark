// gcc -o 2-DPDK 2-DPDK.c -lpthread -static
// Created by nsas2020 on 24-3-15.
#include <stdatomic.h>
#include <stddef.h>    // 或 <stdlib.h> 对于 NULL
#include <sched.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <assert.h>
#include <stdbool.h>

/**
 * http://git.dpdk.org/dpdk/tag/?h=v20.11
lib/librte_eal/include/generic/rte_mcslock.h:47
 * The rte_mcslock_t type.
 * /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  2-DPDK.c -o 2-DPDK.bc
 */
// clang -emit-llvm -S -o 2-DPDK.ll 2-DPDK.c
// time nidhugg --no-spin-assume  -arm 2-DPDK.ll
// cbmc --arch arm64 --mm pso --unwind 1000  2-DPDK.c
typedef struct rte_mcslock {
    _Atomic(struct rte_mcslock *)next;
    atomic_int  locked; /* 1 if the queue locked, 0 otherwise */
} rte_mcslock_t;


// 全局MCS锁变量，初始化为NULL
_Atomic(rte_mcslock_t*) global_lock = NULL;

// 两个全局锁节点变量
rte_mcslock_t global_node1, global_node2;

/**
 * Take the MCS lock.
 *
 * @param msl
 *   A pointer to the pointer of a MCS lock.
 *   When the lock is initialized or declared, the msl pointer should be
 *   set to NULL.
 * @param me
 *   A pointer to a new node of MCS lock. Each CPU/thread acquiring the
 *   lock should use its 'own node'.
 */
static inline void
rte_mcslock_lock(_Atomic(rte_mcslock_t *)*msl, _Atomic(rte_mcslock_t *)me)
{
    rte_mcslock_t *prev;

    /* Init me node */
    //printf("Thread %d: 1: W locked.\n", i);
    atomic_store_explicit(&me->locked, 1, memory_order_relaxed);
    atomic_store_explicit(&me->next, NULL, memory_order_relaxed);

    /* If the queue is empty, the exchange operation is enough to acquire
     * the lock. Hence, the exchange operation requires acquire semantics.
     * The store to me->next above should complete before the node is
     * visible to other CPUs/threads. Hence, the exchange operation requires
     * release semantics as well.
     */
//    prev = atomic_exchange_explicit(msl, me, memory_order_acq_rel);
    prev = msl;
    msl = me;
    if (prev == NULL) {
        /* Queue was empty, no further action required,
         * proceed with lock taken.
         */
        return;
    }
    /* The store to me->next above should also complete before the node is
     * visible to predecessor thread releasing the lock. Hence, the store
     * prev->next also requires release semantics. Note that, for example,
     * on ARM, the release semantics in the exchange operation is not
     * strong as a release fence and is not sufficient to enforce the
     * desired order here.
     */
   // printf("Thread %d: 2: W.next \n", i);
    // right
    //atomic_store_explicit(&prev->next, me, memory_order_release);
    // wrong
    atomic_store_explicit(&prev->next, me, memory_order_relaxed);


    /* The while-load of me->locked should not move above the previous
     * store to prev->next. Otherwise it will cause a deadlock. Need a
     * store-load barrier.
     */
   // atomic_thread_fence(memory_order_acq_rel);
    /* If the lock has already been acquired, it first atomically
     * places the node at the end of the queue and then proceeds
     * to spin on me->locked until the previous lock holder resets
     * the me->locked using mcslock_unlock().
     */
    int timeout = 10000; // 例如，设置为一百万次迭代
    while (atomic_load_explicit(&me->locked, memory_order_acquire)) {
        if (timeout-- >= 0) {
            assert(true); // 断言失败，表示超时
        }
        //sched_yield();
    }
}

/**
 * Release the MCS lock.
 *
 * @param msl
 *   A pointer to the pointer of a MCS lock.
 * @param me
 *   A pointer to the node of MCS lock passed in rte_mcslock_lock.
 */
static inline void
rte_mcslock_unlock(_Atomic(rte_mcslock_t *) *msl, _Atomic(rte_mcslock_t *)me)
{
    //printf("Thread %d: 3: R.next \n", i);
    /* Check if there are more nodes in the queue. */
    if (atomic_load_explicit(&me->next, memory_order_relaxed) == NULL) {
        /* No, last member in the queue. */
        rte_mcslock_t *save_me = atomic_load_explicit(&me, memory_order_relaxed);

        /* Release the lock by setting it to NULL */
//        if (atomic_compare_exchange_strong_explicit(msl, &save_me, NULL, memory_order_release, memory_order_relaxed))
//            return;
        if (msl == save_me) {
            msl = NULL;
            return;
        }
        /* Speculative execution would be allowed to read in the
         * while-loop first. This has the potential to cause a
         * deadlock. Need a load barrier.
         */
        atomic_thread_fence(memory_order_acquire);
        /* More nodes added to the queue by other CPUs.
         * Wait until the next pointer is set.
         */

        while (atomic_load_explicit(&me->next, memory_order_relaxed) == NULL)
            sched_yield();
    }
    //printf("Thread %d: 4: W.locked \n", i);
    /* Pass lock to next waiter. */
    atomic_store_explicit(&me->next->locked, 0, memory_order_release);
}


// 假设已经包含了前面你提供的 rte_mcslock_t 的定义以及
// rte_mcslock_lock 和 rte_mcslock_unlock 函数。


// 加锁函数
void* thread_lock(void* arg) {
    rte_mcslock_t* node = (rte_mcslock_t*)arg;

    // 加锁操作
    rte_mcslock_lock(&global_lock, node);
//    printf("Thread %lu: Lock acquired.\n", pthread_self());
    return NULL;
}

// 解锁函数
void* thread_unlock(void* arg) {
    rte_mcslock_t* node = (rte_mcslock_t*)arg;
    // 解锁操作
    rte_mcslock_unlock(&global_lock, node);
//    printf("Thread %lu: Lock released.\n", pthread_self());
    return NULL;
}

// 主函数
int main(void) {
    pthread_t thread1, thread2, thread3, thread4;

    // 初始化节点
    global_node1.locked = ATOMIC_VAR_INIT(0); // 表示此节点初始时未锁定
    global_node1.next = ATOMIC_VAR_INIT(NULL);
    global_node2.locked = ATOMIC_VAR_INIT(0); // 同上
    global_node2.next = ATOMIC_VAR_INIT(NULL);

    // 创建线程进行加锁和解锁操作
    pthread_create(&thread1, NULL, thread_lock, &global_node1);
    pthread_create(&thread2, NULL, thread_unlock, &global_node1);
    pthread_create(&thread3, NULL, thread_lock, &global_node2);
    pthread_create(&thread4, NULL, thread_unlock, &global_node2);

    // 等待线程结束
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);
    pthread_join(thread4, NULL);

//    printf("All threads have finished execution.\n");

    return 0;
}

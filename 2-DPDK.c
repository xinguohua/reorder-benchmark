//
// Created by nsas2020 on 24-3-15.
//
#include <stdatomic.h>
#include <stddef.h>    // 或 <stdlib.h> 对于 NULL
#include <sched.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
/**
 * http://git.dpdk.org/dpdk/tag/?h=v20.11
lib/librte_eal/include/generic/rte_mcslock.h:47
 * The rte_mcslock_t type.
 * /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  2-DPDK.c -o 2-DPDK.bc
 */
typedef struct rte_mcslock {
    struct rte_mcslock *next;
    int  locked; /* 1 if the queue locked, 0 otherwise */
} rte_mcslock_t;



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
rte_mcslock_lock(rte_mcslock_t **msl, rte_mcslock_t *me, int i)
{
    rte_mcslock_t *prev;

    /* Init me node */
    printf("Thread %d: 1: W locked.\n", i);
    __atomic_store_n(&me->locked, 1, __ATOMIC_RELAXED);
    __atomic_store_n(&me->next, NULL, __ATOMIC_RELAXED);

    /* If the queue is empty, the exchange operation is enough to acquire
     * the lock. Hence, the exchange operation requires acquire semantics.
     * The store to me->next above should complete before the node is
     * visible to other CPUs/threads. Hence, the exchange operation requires
     * release semantics as well.
     */
    prev  = __atomic_exchange_n(msl, me, __ATOMIC_ACQ_REL);

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
    printf("Thread %d: 2: W.next \n", i);
    // right
    //atomic_store_explicit(&prev->next, me, memory_order_release);
    // wrong
    __atomic_store_n(&prev->next, me, __ATOMIC_RELEASE);

    /* The while-load of me->locked should not move above the previous
     * store to prev->next. Otherwise it will cause a deadlock. Need a
     * store-load barrier.
     */
    __atomic_thread_fence(__ATOMIC_ACQ_REL);
    /* If the lock has already been acquired, it first atomically
     * places the node at the end of the queue and then proceeds
     * to spin on me->locked until the previous lock holder resets
     * the me->locked using mcslock_unlock().
     */
    while (__atomic_load_n(&me->locked, __ATOMIC_ACQUIRE)) {
        sched_yield();
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
rte_mcslock_unlock(rte_mcslock_t **msl, rte_mcslock_t *me, int  i)
{
    printf("Thread %d: 3: R.next \n", i);
    /* Check if there are more nodes in the queue. */
    if (__atomic_load_n(&me->next, __ATOMIC_RELAXED) == NULL) {
        printf("Thread %d: NULL \n", i);

        /* No, last member in the queue. */
        rte_mcslock_t *save_me = me;

        /* Release the lock by setting it to NULL */
        if (__atomic_compare_exchange_n(msl, &save_me, NULL, 0, __ATOMIC_RELEASE, __ATOMIC_RELAXED))
            return;

        /* Speculative execution would be allowed to read in the
         * while-loop first. This has the potential to cause a
         * deadlock. Need a load barrier.
         */
        __atomic_thread_fence(__ATOMIC_ACQUIRE);
        /* More nodes added to the queue by other CPUs.
         * Wait until the next pointer is set.
         */

        while (__atomic_load_n(&me->next, __ATOMIC_RELAXED) == NULL)
            sched_yield();
    }
    printf("Thread %d: 4: W.locked \n", i);
    /* Pass lock to next waiter. */
    __atomic_store_n(&me->next->locked, 0, __ATOMIC_RELEASE);
}


// 假设已经包含了前面你提供的 rte_mcslock_t 的定义以及
// rte_mcslock_lock 和 rte_mcslock_unlock 函数。

// 全局MCS锁变量，初始化为NULL
rte_mcslock_t* global_lock = NULL;

// 两个全局锁节点变量
rte_mcslock_t global_node1, global_node2;

//// 加锁函数
//void* thread_lock(void* arg) {
//    rte_mcslock_t* node = (rte_mcslock_t*)arg;
//
//    // 加锁操作
//    rte_mcslock_lock(&global_lock, node, pthread_self());
//    printf("Thread %lu: Lock acquired.\n", pthread_self());
//    return NULL;
//}
//
//// 解锁函数
//void* thread_unlock(void* arg) {
//    rte_mcslock_t* node = (rte_mcslock_t*)arg;
//    // 解锁操作
//    rte_mcslock_unlock(&global_lock, node, pthread_self());
//    printf("Thread %lu: Lock released.\n", pthread_self());
//    return NULL;
//}
//
//// 主函数
//int main() {
//    pthread_t thread1, thread2, thread3, thread4;
//
//    // 初始化节点
//    global_node1.locked = ATOMIC_VAR_INIT(0); // 表示此节点初始时未锁定
//    global_node1.next = ATOMIC_VAR_INIT(NULL);
//    global_node2.locked = ATOMIC_VAR_INIT(0); // 同上
//    global_node2.next = ATOMIC_VAR_INIT(NULL);
//
//    // 创建线程进行加锁和解锁操作
//    pthread_create(&thread1, NULL, thread_lock, &global_node1);
//    pthread_create(&thread2, NULL, thread_unlock, &global_node1);
//    pthread_create(&thread3, NULL, thread_lock, &global_node2);
//    pthread_create(&thread4, NULL, thread_unlock, &global_node2);
//
//    // 等待线程结束
//    pthread_join(thread1, NULL);
//    pthread_join(thread2, NULL);
//    pthread_join(thread3, NULL);
//    pthread_join(thread4, NULL);
//
//    printf("All threads have finished execution.\n");
//
//    return 0;
//}


// ===========dynamic

void* thread_func(void* arg) {
    int thread_id = *(int*)arg;
    rte_mcslock_t* node = (thread_id == 1) ? &global_node1 : &global_node2;

    // 获取锁
    rte_mcslock_lock(&global_lock, node, thread_id);
    if (thread_id == 0)  usleep(2000); // usleep 以微秒为单位，因此乘以 1000

    // 临界区代码
    printf("Thread %d: start\n", thread_id);
    // 模拟一些工作
    printf("Thread %d: end\n", thread_id);

    // 释放锁
    rte_mcslock_unlock(&global_lock, node, thread_id);

    return NULL;
}


int main() {
    pthread_t threads[2];

    // 初始化全局节点
    global_node1.next = NULL;
    global_node1.locked = 0;
    global_node2.next = NULL;
    global_node2.locked = 0;

    // 创建线程
    for (int i = 0; i < 2; i++){
        if (i == 1){
            usleep(300); // usleep 以微秒为单位，因此乘以 1000
        }
        pthread_create(&threads[i], NULL, thread_func, &i);
    }

    // 等待线程结束
    pthread_join(threads[0], NULL);
    pthread_join(threads[1], NULL);

    return 0;
}

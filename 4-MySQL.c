// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  4-MySQL.c -o 4-MySQL.bc  57:104  59:103
//https://bugs.mysql.com/file.php?id=28180&bug_id=94699&text=1
// Created by nsas2020 on 24-3-15.
#include <stdbool.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define X_LOCK_DECR		0x20000000
#define X_LOCK_HALF_DECR	0x10000000
# define os_rmb	__atomic_thread_fence(__ATOMIC_ACQUIRE)
#define os_thread_eq(lhs, rhs)  ((lhs) == (rhs))


typedef pthread_t os_thread_id_t;
os_thread_id_t os_thread_get_curr_id(void) {
    return pthread_self();
}

typedef pthread_mutex_t mutex_t;

// 初始化互斥锁
void mutex_init(mutex_t* mutex) {
    pthread_mutex_init(mutex, NULL);
}

// 进入互斥锁
void mutex_enter(mutex_t* mutex) {
    pthread_mutex_lock(mutex);
}

// 退出互斥锁
void mutex_exit(mutex_t* mutex) {
    pthread_mutex_unlock(mutex);
}


struct rw_lock_t {
    mutex_t mutex; // 互斥锁
    volatile int lock_word;; // 锁的状态，使用原子变量进行原子操作
    os_thread_id_t writer_thread; // 当前写入者线程ID
    bool recursive; // 是否允许递归锁定
    const char* last_x_file_name; // 最后一次尝试获取写锁的文件名
    unsigned int last_x_line; // 最后一次尝试获取写锁的行号
};

void rw_lock_set_writer_id_and_recursion_flag(
/*=====================================*/
        struct rw_lock_t*	lock,		/*!< in/out: lock to work on */
        bool		recursive)	/*!< in: true if recursion
					allowed */
{
    os_thread_id_t	curr_thread	= os_thread_get_curr_id();
    mutex_enter(&lock->mutex);
    printf("1: W writer_thread\n");
    lock->writer_thread = curr_thread;
    printf("2: W writer_recursive\n");
    lock->recursive = recursive;
    mutex_exit(&lock->mutex);
}


bool rw_lock_lock_word_decr(struct rw_lock_t* lock, int amount, int threshold) {
    bool success = false; // 默认设置为失败

    pthread_mutex_lock(&lock->mutex); // 加锁
    if (lock->lock_word > threshold) {
        lock->lock_word -= amount;
        success = true; // 设置成功状态
    }
    pthread_mutex_unlock(&lock->mutex); // 无论如何都解锁

    return success;
}

bool rw_lock_x_lock_low(
/*===============*/
        struct rw_lock_t*	lock,	/*!< in: pointer to rw-lock */
        int		pass,	/*!< in: pass value; != 0, if the lock will
				be passed to another thread to unlock */
        const char*	file_name,/*!< in: file name where lock requested */
        int		line)	/*!< in: line where requested */
{
    if (rw_lock_lock_word_decr(lock, X_LOCK_DECR, X_LOCK_HALF_DECR)) {

        /* Decrement occurred: we are writer or next-writer. */
        rw_lock_set_writer_id_and_recursion_flag(
                lock, !pass);
    } else {
        os_thread_id_t	thread_id = os_thread_get_curr_id();

        if (!pass) {
            os_rmb;
        }

        /* Decrement failed: An X or SX lock is held by either
        this thread or another. Try to relock. */
        printf("3: R recursive\n");
        printf("4: R thread\n");

        if (!pass
            && lock->recursive
            && os_thread_eq(lock->writer_thread, thread_id)) {
            /* Other s-locks can be allowed. If it is request x
            recursively while holding sx lock, this x lock should
            be along with the latching-order. */

            /* The existing X or SX lock is from this thread */
            if (rw_lock_lock_word_decr(lock, X_LOCK_DECR, 0)) {
                /* There is at least one SX-lock from this
                thread, but no X-lock. */

                /* Wait for any the other S-locks to be
                released. */


            } else {
                /* At least one X lock by this thread already
                exists. Add another. */
                if (lock->lock_word == 0
                    || lock->lock_word == -X_LOCK_HALF_DECR) {
                    lock->lock_word -= X_LOCK_DECR;
                } else {
                    --lock->lock_word;
                }
            }

        } else {
            /* Another thread locked before us */
            return 0;
        }
    }


    lock->last_x_file_name = file_name;
    lock->last_x_line = (unsigned int) line;

    return 1;
}


struct rw_lock_t my_lock;

// 线程A的运行函数
void* thread_a_func(void* arg) {
    printf("Thread A is trying to lock...\n");
    if (rw_lock_x_lock_low(&my_lock, 0, __FILE__, __LINE__)) {
        printf("Thread A successfully locked.\n");
    } else {
        printf("Thread A failed to lock.\n");
    }
    // 模拟工作
    sleep(1);

    // 解锁逻辑（根据需要实现）
    return NULL;
}

// 线程B的运行函数
void* thread_b_func(void* arg) {
    printf("Thread B is trying to lock...\n");
    if (rw_lock_x_lock_low(&my_lock, 0, __FILE__, __LINE__)) {
        printf("Thread B successfully locked.\n");
    } else {
        printf("Thread B failed to lock.\n");
    }
    // 解锁逻辑（根据需要实现）
    return NULL;
}

int main() {
    // 初始化锁
    pthread_mutex_init(&my_lock.mutex, NULL);
    my_lock.lock_word = 0x30000000; // 初始化为一个允许A线程锁定的值

    pthread_t thread_a, thread_b;

    // 创建线程A
    if (pthread_create(&thread_a, NULL, thread_a_func, NULL)) {
        perror("Failed to create thread A");
        return 1;
    }

    // 稍作延时以确保线程A先运行
    sleep(1);

    // 创建线程B
    if (pthread_create(&thread_b, NULL, thread_b_func, NULL)) {
        perror("Failed to create thread B");
        return 1;
    }

    // 等待线程结束
    pthread_join(thread_a, NULL);
    pthread_join(thread_b, NULL);

    return 0;
}







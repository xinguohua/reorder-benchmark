//
// Created by nsas2020 on 24-3-13.
//
//
// Created by 辛国华 on 2024/3/13.
//原来的代码
//[54]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64d816cba06c
//改进的代码
//[19]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95bcade33a8a
//Linux内核代码 下载4.5
//https://blog.csdn.net/wtl1992/article/details/121739072
//queued_spin_lock_slowpath::node 382
//
#include <sched.h>
#include <stdatomic.h>
#include <stdint.h>
#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <stdlib.h>
#define READ_ONCE(var) (*(volatile typeof(var) *)&(var))
#define pv_kick_node		__pv_kick_node
#define virt_spin_lock virt_spin_lock
#define bool _Bool
#define true 1
#define false 0
#define this_cpu_dec(counter) atomic_fetch_sub(&(counter), 1)
#define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
				      << _Q_ ## type ## _OFFSET)
#define _Q_LOCKED_OFFSET	0
#define _Q_LOCKED_BITS		8
#define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
#define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
#define _Q_PENDING_BITS		8
#define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
#define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
#define _Q_TAIL_IDX_BITS	2
#define _Q_TAIL_IDX_MASK	_Q_SET_MASK(TAIL_IDX)
#define _Q_TAIL_CPU_OFFSET	(_Q_TAIL_IDX_OFFSET + _Q_TAIL_IDX_BITS)
#define _Q_TAIL_CPU_BITS	(32 - _Q_TAIL_CPU_OFFSET)
#define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
#define _Q_TAIL_OFFSET		_Q_TAIL_IDX_OFFSET
#define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
#define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
#define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
#define MAX_CPUS 4 // 假设最大 CPU 核心数为 4
#define NUM_IDX 2  //

struct mcs_spinlock {
    struct mcs_spinlock *next;
    int locked; /* 1 if lock acquired */
    int count;  /* nesting count, see qspinlock.c */
};
// 假设的简单原子类型
typedef struct {
    volatile int value;
} atomic_t;

typedef struct qspinlock {
    atomic_t	val;
} arch_spinlock_t;

long int getcpu(unsigned *cpu, unsigned *node, void *tcache) {
    return syscall(SYS_getcpu, cpu, node, tcache);
}

static inline long int smp_processor_id(void) {
    unsigned cpu;
    if (getcpu(&cpu, NULL, NULL) != 0) {
        return -1;  // 或者处理错误的其他方式
    }
    return cpu;
}
static __always_inline void __pv_kick_node(struct qspinlock *lock,
                                           struct mcs_spinlock *node) { }

static inline void smp_cond_acquire(bool condition) {
    if (condition) {
        // 这里执行一个内存屏障操作，确保之前的内存操作不会被重排到屏障之后
        __sync_synchronize(); // GCC提供的内建函数，用于插入一个全序屏障
    }
}

static inline int cmpxchg(volatile int *addr, int oldval, int newval) {
    unsigned char ret;
    __asm__ __volatile__ (
            "lock; cmpxchgl %2, %1\n"
            "sete %0\n"
            : "=q" (ret), "+m" (*addr)
            : "r" (newval), "a" (oldval)
            : "memory");
    return ret;
}

#ifdef ARCH_HAS_PREFETCHW
static inline void prefetchw(const void *x)
{
    __builtin_prefetch(x, 1, 3); // '1' indicates a write access, '3' is a temporal locality hint
}
#else
#define prefetchw(x) __builtin_prefetch(x)
#endif

struct mcs_spinlock mcs_nodes[NUM_IDX][MAX_CPUS];



// 实现 smp_store_release，用于在指定的地址上存储一个值，并确保操作具有“释放”语义
#define smp_store_release(ptr, val) \
    atomic_store_explicit((ptr), (val), memory_order_release)

// 定义 arch_mcs_spin_unlock_contended 宏，使用 smp_store_release 设置锁状态为 1
#define arch_mcs_spin_unlock_contended(l) \
    smp_store_release((l), 1)

#define WRITE_ONCE(var, val) \
    (*((volatile typeof(val) *)&(var)) = (val))

#define cpu_relax()	__asm__ __volatile__ ("" : : : "memory")
typedef uint32_t u32;
typedef uint8_t u8;
typedef uint8_t u16;

void *per_cpu_ptr(void *per_cpu_var, int cpu) {
    // 在真实的 Linux 实现中，会有复杂的机制来保证内存访问的正确性和性能
    // 这里的实现仅为示意
    return ((char **)per_cpu_var)[cpu];
}

static inline struct mcs_spinlock *decode_tail(u32 tail)
{
    int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
    int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;

    return per_cpu_ptr(&mcs_nodes[idx], cpu);
}


static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
#define pv_init_node		__pv_init_node


#ifndef arch_mcs_spin_lock_contended
/*
 * Using smp_load_acquire() provides a memory barrier that ensures
 * subsequent operations happen after the lock is acquired.
 */
static inline void cpu_relax_lowlatency() {
    // 在这里，我们使用了x86的pause指令，适用于自旋等待场景
    // 对于需要低延迟的实现，这个函数可以根据具体需求进行调整
    __asm__ volatile("pause" ::: "memory");
}
#define arch_mcs_spin_lock_contended(l)					\
do {									\
	while (!(smp_load_acquire(l)))					\
		cpu_relax_lowlatency();					\
} while (0)
#endif




struct __qspinlock {
    union {
        atomic_int val;
#ifdef __LITTLE_ENDIAN
        struct {
            u8	locked;
            u8	pending;
        };
        struct {
            u16	locked_pending;
            u16	tail;
        };
#else
        struct {
			u16	tail;
			u16	locked_pending;
		};
		struct {
			u8	reserved[2];
			u8	pending;
			u8	locked;
		};
#endif
    };
};

#define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
#define _Q_TAIL_IDX_BITS	2
#define _Q_TAIL_IDX_MASK	_Q_SET_MASK(TAIL_IDX)

#define _Q_TAIL_CPU_OFFSET	(_Q_TAIL_IDX_OFFSET + _Q_TAIL_IDX_BITS)

#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)

#define CURRENT_CORE_ID 0 // 假设当前CPU核心ID总是0

static inline struct mcs_spinlock* this_cpu_ptr(struct mcs_spinlock (*mcs_nodes)[4]) {
    return &((*mcs_nodes)[CURRENT_CORE_ID]);
}

#define pv_wait_node		__pv_wait_node
static __always_inline void __pv_wait_node(struct mcs_spinlock *node,
                                           struct mcs_spinlock *prev) { }



// 原子读操作
int atomic_read(atomic_t *v) {
    return v->value;
}


// 原子比较并交换
// 如果 *ptr 的值等于 oldVal，则将 *ptr 设置为 newVal
// 返回值是 *ptr 操作前的值
int atomic_cmpxchg(atomic_t *ptr, int oldVal, int newVal) {
    // 定义一个变量用于保存旧值
    int old;

    // 执行比较并交换操作
    __asm__ __volatile__ (
            "lock cmpxchgl %2, %1\n\t"   // 使用cmpxchgl指令执行比较并交换操作
            : "=a" (old), "+m" (ptr->value)   // 输出：将旧值存储到old中，并将ptr->value作为内存操作数
            : "r" (newVal), "0" (oldVal)   // 输入：将newVal和oldVal作为寄存器操作数
            : "memory"   // 告诉编译器内存操作数被修改了
            );

    // 返回旧值
    return old;
}
// 原子比较并交换（获取模式）
// 这里为了示例，实现与 atomic_cmpxchg 相同。在实践中，它可能会添加额外的内存屏障来保证获取语义。
int atomic_cmpxchg_acquire(atomic_t *ptr, int oldVal, int newVal) {
    // 在实际的多处理器系统中，这里可能需要一个获取屏障
    return atomic_cmpxchg(ptr, oldVal, newVal);
}
static inline uint16_t smp_load_acquire(volatile int * ptr) {
    // 使用GCC内建的__atomic_load_n函数来加载值
    // __ATOMIC_ACQUIRE内存顺序确保在此操作之前的所有写操作对当前线程都是可见的
    uint16_t value = __atomic_load_n(ptr, __ATOMIC_ACQUIRE);
    return value;
}

static inline u32 encode_tail(int cpu, int idx)
{
    u32 tail;

    tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
    tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */

    return tail;
}

static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
{
    struct __qspinlock *l = (void *)lock;

    WRITE_ONCE(l->locked_pending, _Q_LOCKED_VAL);
}


static inline void smp_mb__before_atomic(void) {
    __asm__ __volatile__("mfence":::"memory");
}

static inline void atomic_sub(int i, atomic_t *v) {
    __asm__ __volatile__(
            "lock; subl %1, %0"
            : "+m" (v->value)  // 直接操作atomic_t结构中的counter成员
            : "ir" (i)
            : "memory");
}
static __always_inline void set_locked(struct qspinlock *lock)
{
    struct __qspinlock *l = (void *)lock;

    WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
}

static __always_inline int queued_spin_trylock(struct qspinlock *lock)
{
    if (!atomic_read(&lock->val) &&
        (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
        return 1;
    return 0;
}
static inline uint32_t xchg_release(volatile u16 ptr, uint16_t newval) {
    // 使用 GCC 内联汇编来实现 xchg 操作，具有释放语义
    uint16_t oldval;
    __asm__ __volatile__(
            "xchgw %0, %1" // 执行交换操作，对于16位操作使用"xchgw"
            : "=r" (oldval), "+m" (ptr)
            : "0" (newval)
            : "memory" // 确保所有之前的存储操作在交换之前完成
            );
    return oldval; // 返回旧值
}

static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
{
    struct __qspinlock *l = (void *)lock;

    /*
     * Use release semantics to make sure that the MCS node is properly
     * initialized before changing the tail code.
     */
    return (u32)xchg_release(l->tail,
                             tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
}

static inline int atomic_cmpxchg_relaxed(volatile int *ptr, int oldVal, int newVal) {
    // 使用__atomic_compare_exchange_n内建函数进行原子比较和交换
    // 注意：这里假设__ATOMIC_RELAXED内存模型适用于您的场景
    int expected = oldVal;
    __atomic_compare_exchange_n(ptr, &expected, newVal, false, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
    return expected; // 如果成功，expected未被修改；如果失败，expected被更新为*ptr的当前值
}

struct pv_node {
    struct mcs_spinlock	mcs;
    struct mcs_spinlock	__res[3];

    int			cpu;
    u8			state;
};

enum vcpu_state {
    vcpu_running = 0,
    vcpu_halted,		/* Used only in pv_wait_node */
    vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
};
enum qlock_stats {
    qstat_pv_hash_hops,
    qstat_pv_kick_unlock,
    qstat_pv_kick_wake,
    qstat_pv_latency_kick,
    qstat_pv_latency_wake,
    qstat_pv_lock_stealing,
    qstat_pv_spurious_wakeup,
    qstat_pv_wait_again,
    qstat_pv_wait_early,
    qstat_pv_wait_head,
    qstat_pv_wait_node,
    qstat_num,	/* Total number of statistical counters */
    qstat_reset_cnts = qstat_num,
};


#define pv_kick(c)	__pv_kick(c)
#define pv_wait(p, v)	__pv_wait(p, v)


/*
 * The pending bit is used by the queue head vCPU to indicate that it
 * is actively spinning on the lock and no lock stealing is allowed.
 */
#if _Q_PENDING_BITS == 8
static __always_inline void set_pending(struct qspinlock *lock)
{
    struct __qspinlock *l = (void *)lock;

    WRITE_ONCE(l->pending, 1);
}

static __always_inline void clear_pending(struct qspinlock *lock)
{
    struct __qspinlock *l = (void *)lock;

    WRITE_ONCE(l->pending, 0);
}

/*
 * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
 * barrier. Therefore, an atomic cmpxchg() is used to acquire the lock
 * just to be sure that it will get it.
 */
static __always_inline int trylock_clear_pending(struct qspinlock *lock)
{
    struct __qspinlock *l = (void *)lock;

    return !READ_ONCE(l->locked) &&
           (cmpxchg(&l->locked_pending, _Q_PENDING_VAL, _Q_LOCKED_VAL)
            == _Q_PENDING_VAL);
}
#else /* _Q_PENDING_BITS == 8 */
static __always_inline void set_pending(struct qspinlock *lock)
{
	atomic_set_mask(_Q_PENDING_VAL, &lock->val);
}

static __always_inline void clear_pending(struct qspinlock *lock)
{
	atomic_clear_mask(_Q_PENDING_VAL, &lock->val);
}

static __always_inline int trylock_clear_pending(struct qspinlock *lock)
{
	int val = atomic_read(&lock->val);

	for (;;) {
		int old, new;

		if (val  & _Q_LOCKED_MASK)
			break;

		/*
		 * Try to clear pending bit & set locked bit
		 */
		old = val;
		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
		val = atomic_cmpxchg(&lock->val, old, new);

		if (val == old)
			return 1;
	}
	return 0;
}
#endif /* _Q_PENDING_BITS == 8 */


/* How long a lock should spin before we consider blocking */
#define SPIN_THRESHOLD	(1 << 15)



#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
static inline int xchg(volatile int *addr, int newval) {
    int result;

    // 以下是基于GCC的x86内联汇编语法
    // "xchg %0, %1" : 表示使用xchg指令交换操作数
    // "+m" (*addr) : 表示操作数是内存地址addr，"+"表示这是一个读写操作
    // "+r" (newval) : 表示操作数是寄存器中的newval，"+"表示这也是一个读写操作
    // : "memory" : 告诉编译器该操作可能会影响内存，防止编译器做过度优化
    __asm__ __volatile__("xchg %0, %1"
            : "+m" (*addr), "+r" (newval)
            : : "memory");
    result = newval;

    return result;
}

static u32
pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
{
    struct pv_node *pn = (struct pv_node *)node;
    struct __qspinlock *l = (void *)lock;
    struct qspinlock **lp = NULL;
    int waitcnt = 0;
    int loop;

    /*
     * If pv_kick_node() already advanced our state, we don't need to
     * insert ourselves into the hash table anymore.
     */
    if (READ_ONCE(pn->state) == vcpu_hashed)
        lp = (struct qspinlock **)1;

    for (;; waitcnt++) {
        /*
         * Set correct vCPU state to be used by queue node wait-early
         * mechanism.
         */
        WRITE_ONCE(pn->state, vcpu_running);

        /*
         * Set the pending bit in the active lock spinning loop to
         * disable lock stealing before attempting to acquire the lock.
         */
        set_pending(lock);
        for (loop = SPIN_THRESHOLD; loop; loop--) {
            if (trylock_clear_pending(lock))
                goto gotlock;
            cpu_relax();
        }
        clear_pending(lock);


        if (!lp) { /* ONCE */


            /*
             * We must hash before setting _Q_SLOW_VAL, such that
             * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
             * we'll be sure to be able to observe our hash entry.
             *
             *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
             *       MB                           RMB
             * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
             *
             * Matches the smp_rmb() in __pv_queued_spin_unlock().
             */
            if (xchg(&l->locked, _Q_SLOW_VAL) == 0) {
                /*
                 * The lock was free and now we own the lock.
                 * Change the lock value back to _Q_LOCKED_VAL
                 * and unhash the table.
                 */
                WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
                WRITE_ONCE(*lp, NULL);
                goto gotlock;
            }
        }
        WRITE_ONCE(pn->state, vcpu_halted);

    }

    /*
     * The cmpxchg() or xchg() call before coming here provides the
     * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
     * here is to indicate to the compiler that the value will always
     * be nozero to enable better code optimization.
     */
    gotlock:
    return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
}




void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
{
    struct mcs_spinlock *prev, *next, *node;
    u32 new, old, tail;
    int idx;

    /*
     * wait for in-progress pending->locked hand-overs
     *
     * 0,1,0 -> 0,0,1
     */
    if (val == _Q_PENDING_VAL) {
        while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
            cpu_relax();
    }

    /*
     * trylock || pending
     *
     * 0,0,0 -> 0,0,1 ; trylock
     * 0,0,1 -> 0,1,1 ; pending
     */
    for (;;) {
        /*
         * If we observe any contention; queue.
         */
        if (val & ~_Q_LOCKED_MASK)
            goto queue;

        new = _Q_LOCKED_VAL;
        if (val == new)
            new |= _Q_PENDING_VAL;

        /*
         * Acquire semantic is required here as the function may
         * return immediately if the lock was free.
         */
        old = atomic_cmpxchg_acquire(&lock->val, val, new);
        if (old == val)
            break;

        val = old;
    }

    /*
     * we won the trylock
     */
    if (new == _Q_LOCKED_VAL)
        return;

    /*
     * we're pending, wait for the owner to go away.
     *
     * *,1,1 -> *,1,0
     *
     * this wait loop must be a load-acquire such that we match the
     * store-release that clears the locked bit and create lock
     * sequentiality; this is because not all clear_pending_set_locked()
     * implementations imply full barriers.
     */
    val = lock->val.value;
    while (val & _Q_LOCKED_MASK){
        val = lock->val.value;
        cpu_relax();
    }


    /*
     * take ownership and clear the pending bit.
     *
     * *,1,0 -> *,0,1
     */
    clear_pending_set_locked(lock);
    return;

    /*
     * End of pending bit optimistic spinning and beginning of MCS
     * queuing.
     */
    queue:
    node = this_cpu_ptr(&mcs_nodes[0]);
    idx = node->count++;
    tail = encode_tail(smp_processor_id(), idx);

    node += idx;
    node->locked = 0;
    printf("Hello, World1!\n");
    node->next = NULL;
    pv_init_node(node);

    /*
     * We touched a (possibly) cold cacheline in the per-cpu queue node;
     * attempt the trylock once more in the hope someone let go while we
     * weren't watching.
     */
    if (queued_spin_trylock(lock))
        goto release;

    /*
     * We have already touched the queueing cacheline; don't bother with
     * pending stuff.
     *
     * p,*,* -> n,*,*
     */
    old = xchg_tail(lock, tail);
    next = NULL;

    /*
     * if there was a previous node; link it and wait until reaching the
     * head of the waitqueue.
     */
    if (old & _Q_TAIL_MASK) {
        prev = decode_tail(old);
        WRITE_ONCE(prev->next, node);
        printf("Hello, World2\n");
        pv_wait_node(node, prev);
        arch_mcs_spin_lock_contended(&node->locked);

        /*
         * While waiting for the MCS lock, the next pointer may have
         * been set by another lock waiter. We optimistically load
         * the next pointer & prefetch the cacheline for writing
         * to reduce latency in the upcoming MCS unlock operation.
         */
        next = READ_ONCE(node->next);
        if (next)
            prefetchw(next);
    }

    /*
     * we're at the head of the waitqueue, wait for the owner & pending to
     * go away.
     *
     * *,x,y -> *,0,0
     *
     * this wait loop must use a load-acquire such that we match the
     * store-release that clears the locked bit and create lock
     * sequentiality; this is because the set_locked() function below
     * does not imply a full barrier.
     *
     * The PV pv_wait_head_or_lock function, if active, will acquire
     * the lock and return a non-zero value. So we have to skip the
     * smp_load_acquire() call. As the next PV queue head hasn't been
     * designated yet, there is no way for the locked value to become
     * _Q_SLOW_VAL. So both the set_locked() and the
     * atomic_cmpxchg_relaxed() calls will be safe.
     *
     * If PV isn't active, 0 will be returned instead.
     *
     */
    if ((val = pv_wait_head_or_lock(lock, node)))
        goto locked;

    smp_cond_acquire(!((val = atomic_read(&lock->val)) & _Q_LOCKED_PENDING_MASK));

    locked:
    /*
     * claim the lock:
     *
     * n,0,0 -> 0,0,1 : lock, uncontended
     * *,0,0 -> *,0,1 : lock, contended
     *
     * If the queue head is the only one in the queue (lock value == tail),
     * clear the tail code and grab the lock. Otherwise, we only need
     * to grab the lock.
     */
    for (;;) {
        /* In the PV case we might already have _Q_LOCKED_VAL set */
        if ((val & _Q_TAIL_MASK) != tail) {
            set_locked(lock);
            break;
        }
        /*
         * The smp_load_acquire() call above has provided the necessary
         * acquire semantics required for locking. At most two
         * iterations of this loop may be ran.
         */
        old = atomic_cmpxchg_relaxed(&lock->val.value, val, _Q_LOCKED_VAL);
        if (old == val)
            goto release;	/* No contention */

        val = old;
    }

    /*
     * contended path; wait for next if not observed yet, release.
     */
    if (!next) {
        printf("Hello, World3\n");

        while (!(next = READ_ONCE(node->next)))
            cpu_relax();
    }
    printf("Hello, World4\n");
    arch_mcs_spin_unlock_contended(&next->locked);
    pv_kick_node(lock, next);

    release:
    /*
     * release the node
     */
    this_cpu_dec(mcs_nodes[0]->count);
}

/**
 * queued_spin_lock - acquire a queued spinlock
 * @lock: Pointer to queued spinlock structure
 */
static __always_inline void queued_spin_lock(struct qspinlock *lock)
{
    u32 val;

    val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
    if (val == 0) // 移除了 likely
        return;
    queued_spin_lock_slowpath(lock, val);
}


/**
 * queued_spin_unlock - release a queued spinlock
 * @lock : Pointer to queued spinlock structure
 */
static __always_inline void queued_spin_unlock(struct qspinlock *lock)
{
    /*
     * smp_mb__before_atomic() in order to guarantee release semantics
     */
    smp_mb__before_atomic();
    atomic_sub(_Q_LOCKED_VAL, &lock->val);
}

#define NUM_THREADS 100 // 假设有4个线程，可以根据需要调整
void* thread_func(void* arg) {
    struct qspinlock *lock = (struct qspinlock *)arg;
    // 确保线程启动顺序的随机性
    usleep((rand() % 10) * 1000); // 0-9毫秒的延迟
    queued_spin_lock(lock);
    // 做一些工作...
    for (volatile int i = 0; i < 1000000; ++i) {}
    queued_spin_unlock(lock);
   // queued_spin_unlock(lock);

    return NULL;
}

int main() {
    pthread_t threads[NUM_THREADS];
    struct qspinlock lock = { .val = 0 };


    for (int i = 0; i < NUM_THREADS; ++i) {
        if (pthread_create(&threads[i], NULL, thread_func, &lock)) {
            return 1;
        }
    }

    for (int i = 0; i < NUM_THREADS; ++i) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}
///usr/local/clang-4.0/bin/clang++ -emit-llvm -g -c  -std=c++14 20-JDK.cpp  -o 20-JDK.bc
// Created by nsas2020 on 24-3-18.
//https://bugs.openjdk.org/browse/JDK-8221584
//


#include <iostream>
#include <atomic>
#include <thread>
#include <cassert>
#include <vector>
#include <chrono>
#include <unistd.h> // 为了使用 usleep

enum ObjectWaiterState {
    TS_ENTER, TS_RUN
};

class ParkEvent {
public:
    void reset() {}

    void park() {
        std::this_thread::yield(); // 简化为让出CPU时间片
    }

    void unpark() {}
};


class Thread {
public:
    ParkEvent *_ParkEvent;

    Thread() : _ParkEvent(new ParkEvent()) {}

    ~Thread() {
        delete _ParkEvent;
    }
};


class ObjectWaiter {
public:
    std::atomic<ObjectWaiterState> TState;
    ObjectWaiter *_next;
    ParkEvent *_event;
    Thread *_ownerThread;

    ObjectWaiter() : TState(TS_ENTER), _next(nullptr), _event(new ParkEvent()) {}

    ObjectWaiter(Thread *ownerThread) : TState(TS_ENTER), _next(nullptr), _event(new ParkEvent()),
                                        _ownerThread(ownerThread) {}

    ~ObjectWaiter() {
        delete _event;
    }
};

class Atomic {
public:
    static bool replace_if_null(Thread *expected, std::atomic<Thread *> *atomic_owner) {
        Thread *null_thread = nullptr;
        return atomic_owner->compare_exchange_strong(null_thread, expected);
    }
};

class JvmtiRawMonitor {
    std::atomic<Thread *> _owner;
    ObjectWaiter *_EntryList;

public:
    JvmtiRawMonitor() : _owner(nullptr), _EntryList(nullptr) {}

    int SimpleEnter(Thread *Self) {
        //for (;;) {
            ObjectWaiter Node(Self);
            Self->_ParkEvent->reset();
            Node.TState = TS_ENTER;
            // 模拟获取锁
            Node._next = _EntryList;
            _EntryList = &Node;
            // 模拟释放锁
            while (Node.TState.load() == TS_ENTER) {
                printf("2222");
                Self->_ParkEvent->park();
            }
        //}
    }

    int SimpleExit(Thread *Self) {
        //  assert(_owner.load() == Self); // invariant
        // 模拟内存屏障
        if (_EntryList == nullptr) return 0; // OS_OK

        ObjectWaiter *w;
        // 模拟获取锁
        w = _EntryList;
        if (w != nullptr) {
            _EntryList = w->_next;
        }

        // 模拟释放锁
        if (w != nullptr) {
            printf("111");

            assert(w->TState == TS_ENTER); // invariant
            ParkEvent *ev = w->_event;
            //OrderAccess::loadstore();
            w->TState.store(TS_RUN);
            // 模拟内存屏障
            ev->unpark();
        }
        return 0; // OS_OK
    }

};


void enter(JvmtiRawMonitor *monitor, Thread *thread) {
    monitor->SimpleEnter(thread);
    std::cout << "Thread entered" << std::endl;
}

void myExit(JvmtiRawMonitor *monitor, Thread *thread) {
    monitor->SimpleExit(thread);
    std::cout << "Thread exited" << std::endl;
}

int main() {
    JvmtiRawMonitor monitor;
    Thread thread1, thread2;

    // 创建并启动线程，交替调用SimpleEnter和SimpleExit
    std::thread p1(enter, &monitor, &thread1);
    usleep(100000);
    std::thread p2(myExit, &monitor, &thread2);

    p1.join();
    p2.join();

    return 0;
}
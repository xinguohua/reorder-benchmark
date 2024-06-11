///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  20-JDK.c  -o 20-JDK.bc
// Created by nsas2020 on 24-3-18. (31, 51) (49,33)
//https://bugs.openjdk.org/browse/JDK-8221584
//


#include <stdio.h>
#include <pthread.h>
#include <unistd.h> // For usleep
#include <semaphore.h> // For sem_t


typedef enum {
    TS_ENTER, TS_RUN
} ObjectWaiterState;


sem_t semaphore;

typedef struct ObjectWaiter {
    ObjectWaiterState state;
    struct ObjectWaiter* next;
}ObjectWaiter;

ObjectWaiter* entryList = NULL;

void SimpleEnter(ObjectWaiter* node) {
    node->state = TS_ENTER;
    node->next = entryList;
    entryList = node;
    while (node->state == TS_ENTER) {
        printf("2222\n");
        sem_wait(&semaphore); // 等待信号量
    }
}

void SimpleExit() {
    if (entryList == NULL) return; // OS_OK

    ObjectWaiter *w = entryList;

    if (w != NULL) {
        entryList = w->next;
    }

    // Simulating unlocking
    if (w != NULL) {
        printf("111\n");
        sem_post(&semaphore);
        // need barier OrderAccess::loadstore();
        w->state = TS_RUN;
    }
}


void* threadFuncEnter(void* arg) {
    ObjectWaiter* node = (ObjectWaiter*)arg;
    SimpleEnter(node);
    return NULL;
}

void* threadFuncExit(void* arg) {
    (void)arg; // Unused parameter
    SimpleExit();
    return NULL;
}

void InitObjectWaiter() {
    sem_init(&semaphore, 0, 0); // 第二个参数0表示信号量是线程间的，初始值为0
}

int main() {
    pthread_t t1, t2;
    ObjectWaiter node; // 声明ObjectWaiter实例
    InitObjectWaiter(); // 初始化ObjectWaiter实例中的信号量

    pthread_create(&t1, NULL, threadFuncEnter, &node);
    usleep(100000); // 短暂暂停以让t1开始
    pthread_create(&t2, NULL, threadFuncExit, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    sem_destroy(&semaphore); // 销毁信号量资源

    return 0;
}


///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  20-JDK.c  -o 20-JDK.bc
// Created by nsas2020 on 24-3-18. (31, 51) (49,33)
//https://bugs.openjdk.org/browse/JDK-8221584
//

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h> // For usleep
#include <semaphore.h> // For sem_t


typedef enum {
    TS_ENTER, TS_RUN
} ObjectWaiterState;


int semaphore;

typedef struct ObjectWaiter {
    ObjectWaiterState state;
    struct ObjectWaiter* next;
}ObjectWaiter;

ObjectWaiter* entryList = NULL;
ObjectWaiter* node;
void SimpleEnter() {
    node->state = TS_ENTER;
    node->next = entryList;
    entryList = node;
    while (node->state == TS_ENTER) {
        printf("2222\n");
        if(!semaphore) break;
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
        semaphore = 1;
        // need barier OrderAccess::loadstore();
        w->state = TS_RUN;
    }
}


void* threadFuncEnter(void* arg) {
    SimpleEnter(node);
    return NULL;
}

void* threadFuncExit(void* arg) {
    (void)arg; // Unused parameter
    SimpleExit();
    return NULL;
}

int main() {
    pthread_t t1, t2;
    node = (ObjectWaiter*)malloc(sizeof(ObjectWaiter));

    pthread_create(&t1, NULL, threadFuncEnter, &node);
    usleep(100000); // 短暂暂停以让t1开始
    pthread_create(&t2, NULL, threadFuncExit, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    return 0;
}


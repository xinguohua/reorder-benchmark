// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c 5-StackOverFlowEasy.c -o 5-StackOverFlow.bc
//// Created by nsas2020 on 24-3-15. 36:20 23:34
////http://stackoverflow:com/questions/16159203/
// clang -emit-llvm -S -o 5-StackOverFlowEasy.ll 5-StackOverFlowEasy.c
// nidhugg --unroll=10 --transform=StackOverFlowEasy.trans.ll 5-StackOverFlowEasy.ll
// time nidhugg -arm StackOverFlowEasy.trans.ll
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <assert.h>

// 用结构体代替C++中的Point类
typedef struct {
    int x, y;
} Point;

// 全局变量来模拟C++中的静态成员变量
Point *currentPos;
pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

// 更新位置的函数，类似于C++中的A::f()
void* f(void *arg) {
    while (currentPos != NULL) {
        pthread_mutex_lock(&mtx);
        assert(currentPos->x + 1 == currentPos->y);
        if (currentPos->x + 1 != currentPos->y) {
           // printf("%d------- %d\n", currentPos->x, currentPos->y);
           // exit(1);
        }
        pthread_mutex_unlock(&mtx);
    }
}

// 线程函数，模拟C++中的threadFunction
void* threadFunction(void *arg) {
    while (1) {
        Point* addr = malloc(sizeof(Point));
        addr->x = currentPos->x + 1;
        addr->y = currentPos->y + 1;
        currentPos = addr;
    }
}

int main() {
    pthread_t t1, t2;

    // 初始化currentPos
    currentPos = malloc(sizeof(Point));
    currentPos->x = 1;
    currentPos->y = 2;

    // 创建线程
    if (pthread_create(&t1, NULL, &f, NULL)) {
        //fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    if (pthread_create(&t2, NULL, &threadFunction, NULL)) {
        //fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    // 等待线程结束，虽然实际上永远不会到达这里
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    free(currentPos);
    return 0;
}
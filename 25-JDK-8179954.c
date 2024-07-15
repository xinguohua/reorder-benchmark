// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c 25-JDK-8179954.c  -o 25-JDK-8179954.bc
// Created by nsas2020 on 24-7-14.
// https://bugs.openjdk.org/browse/JDK-8179954

#include <stdio.h>
#include <pthread.h>

// 全局变量
volatile int x = 0;
volatile int y = 0;
volatile int r1 = 0;
volatile int r2 = 0;

// 线程1的函数
void* thread1_func(void* arg) {
    x = 1;  // 写入x
    // 没有内存屏障
    r1 = y;  // 读取y
    return NULL;
}

// 线程2的函数
void* thread2_func(void* arg) {
    y = 1;  // 写入y
    // 没有内存屏障
    r2 = x;  // 读取x
    return NULL;
}

int main() {
    pthread_t thread1, thread2;

    // 创建线程1
    pthread_create(&thread1, NULL, thread1_func, NULL);

    // 创建线程2
    pthread_create(&thread2, NULL, thread2_func, NULL);

    // 等待线程1完成
    pthread_join(thread1, NULL);

    // 等待线程2完成
    pthread_join(thread2, NULL);

    // 打印结果
    printf("r1 = %d, r2 = %d\n", r1, r2);

    return 0;
}

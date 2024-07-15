//
// Created by nsas2020 on 24-3-19.
//
//
// Created by nsas2020 on 23-11-8.
// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c 0-datarace.cpp -o datarace1.bc
//0.005769
// dynamic
// /ufo/build/bin/clang -fsanitize=thread -g -o0 -Wall 0-datarace.cpp -o datarace
#include <stdio.h>
#include <pthread.h>
#include <string.h> // 包含字符串操作函数的库


int data = 0; // 全局变量，表示要共享的数据
int flag = 0; // 全局变量，作为一个信号，指示数据是否已写入
char str[50]; // 声明一个足够大的字符数组来存储生成的字符串



// 线程1的函数
void *writer_thread(void *args) {
    data = 42; // 写入数据
    __atomic_store_n(&flag, 1, __ATOMIC_RELEASE);
    return NULL;
}

// 线程2的函数
void *reader_thread(void *args) {
    // 这个循环检查flag是否为1，但如果指令重排发生，
    // flag可能先被设置为1，而data还未被写入正确的值
    if (flag == 1) {
        sprintf(str, "Data happen %d", data);
    }
    return NULL;
}

int main() {
    pthread_t writer, reader;
    int num = 0;

    // 创建两个线程
    pthread_create(&writer, NULL, writer_thread, NULL);
    pthread_create(&reader, NULL, reader_thread, NULL);

    // 等待线程结束
    pthread_join(writer, NULL);
    pthread_join(reader, NULL);

    if (strcmp(str, "Data happen 0") == 0) {
        num++;
        printf("%s\n", str);
    }
    data = 0;
    memset(str, 0, sizeof(str));
    return 0;
}
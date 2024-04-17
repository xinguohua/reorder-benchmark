// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  6-ompi.c -o 6-ompi.bc 36:57  39:60
// Created by nsas2020 on 24-3-15.
//https://github.com/open-mpi/ompi/issues/8274
// clang -emit-llvm -S -o 6-ompi.ll 6-ompi.c
// nidhugg --unroll=10 --transform=6-ompi.trans.ll 6-ompi.ll
// time nidhugg -arm 6-ompi.trans.ll
#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>
#include <pthread.h>

// 模拟Open MPI和OPAL的相关定义
#define OPAL_SUCCESS 0
#define OPAL_ERROR -1

// 简化的调试输出宏和模拟的进度函数
#define opal_output_verbose(level, output, ...) printf(__VA_ARGS__)
#define OMPI_NAME_PRINT(name) "OMPI_PROC"
#define OMPI_PROC_MY_NAME "MY_NAME"

void opal_progress() {
}

typedef struct {
    bool active;
    int status;
} myreg_t;

static myreg_t trkall; // 将trk声明为全局变量，以便在多个线程中使用


int ompi_interlib_declare(myreg_t *trk) {
//    printf("1\n");
    trk->active = true;
//    printf("2\n");

    trk->status = OPAL_ERROR; // 初始状态设置为错误

    // 使用循环代替OMPI_LAZY_WAIT_FOR_COMPLETION宏
    while (trk->active) {
        opal_progress();
        //usleep(100);
    }

    assert(trk-> status == OPAL_SUCCESS);

    return trk->status;
}

// model_registration_callback函数定义
static void model_registration_callback(myreg_t *trk) {


    // 这里模拟事件处理器注册完成后的回调逻辑
//    printf("3\n");
    trk->status = OPAL_SUCCESS;
   // asm volatile("" ::: "memory"); // 内存屏障，确保ARM CPU上的操作顺序
//    printf("4\n");
    trk->active = false;
}

// 线程函数封装
void* ompi_interlib_declare_thread(void* arg) {
    int result = ompi_interlib_declare(&trkall);
    printf("ompi_interlib_declare: %d\n", result);
    return NULL;
}

void* model_registration_callback_thread(void* arg) {
    // 稍微延迟执行，确保ompi_interlib_declare先运行
    //sleep(500);
    for (int k=0; k< 10000; k++);
    model_registration_callback(&trkall);
    printf("model_registration_callback executed\n");
    return NULL;
}


int main() {
    pthread_t thread1, thread2;

    // 创建线程执行ompi_interlib_declare
    pthread_create(&thread1, NULL, ompi_interlib_declare_thread, NULL);
    // 创建线程执行model_registration_callback
    pthread_create(&thread2, NULL, model_registration_callback_thread, NULL);

    // 等待线程完成
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    return 0;
}

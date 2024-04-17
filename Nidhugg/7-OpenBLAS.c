// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  7-OpenBLAS.c -o 7-OpenBLAS.bc （26，42）
// Created by nsas2020 on 24-3-16.
// clang -emit-llvm -S -o 7-OpenBLAS.ll 7-OpenBLAS.c
// nidhugg --unroll=10 --transform=7-OpenBLAS.trans.ll 7-OpenBLAS.ll
// time nidhugg -arm 7-OpenBLAS.trans.ll
// https://github.com/OpenMathLib/OpenBLAS/issues/2444
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h> // 为了使用 usleep

#define NUM_BUFFERS 192
#define NUM_THREADS 96

int memory[NUM_BUFFERS];

void init_memory() {
    for (int i = 0; i < NUM_BUFFERS; i++) {
        memory[i] = 0; // Initialize all memory buffers as unused
    }
}


int allocate_memory() {
    for (int position = 0; position < NUM_BUFFERS; position++) {
        //__atomic_thread_fence(__ATOMIC_ACQUIRE);
        //确保了在这个屏障之后的所有读操作（以及依赖于这些读操作的写操作）
        if (memory[position] == 0) {
            assert(memory[position] == 0);
            memory[position] = 1;
            //printf("Allocated memory buffer %d\n", position);
            return position; // 返回分配的内存位置
        }
    }
    return -1; // 没有可用的内存单元
}

void release_memory(int position) {
    if (position < 0 || position >= NUM_BUFFERS) {
       // printf("Invalid memory buffer position %d\n", position);
        return;
    }
    // arm: ensure all writes are finished before other thread takes this memory
    __atomic_thread_fence(__ATOMIC_RELEASE);
    memory[position] = 0;
    printf("Released memory buffer %d\n", position);
}

void* thread_function(void* arg) {
    int allocated_position = allocate_memory();
    if (allocated_position != -1) {
        printf("Do something with memory buffer %d\n", allocated_position);


        // 模拟执行操作时的随机延迟
       // unsigned int delay = rand() % 1000000; // 生成一个随机延迟（0到999999微秒）
       // usleep(delay); // 以微秒为单位的延迟

        release_memory(allocated_position);
    }
    return NULL;
}

int main() {
    pthread_t threads[NUM_THREADS];

    init_memory();

    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_create(&threads[i], NULL, thread_function, NULL);
    }

    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

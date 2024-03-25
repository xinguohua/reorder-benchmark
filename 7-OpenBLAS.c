// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  7-OpenBLAS.c -o 7-OpenBLAS.bc
// Created by nsas2020 on 24-3-16.
//
// https://github.com/OpenMathLib/OpenBLAS/issues/2444
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h> // 为了使用 usleep

#define NUM_BUFFERS 192
#define NUM_THREADS 96

typedef struct {
    volatile int used;
    pthread_mutex_t lock;
} MemoryCell;

MemoryCell memory[NUM_BUFFERS];

void init_memory() {
    for (int i = 0; i < NUM_BUFFERS; i++) {
        memory[i].used = 0;
        pthread_mutex_init(&memory[i].lock, NULL);
    }
}

int allocate_memory() {
    for (int position = 0; position < NUM_BUFFERS; position++) {
        pthread_mutex_lock(&memory[position].lock);
        //__atomic_thread_fence(__ATOMIC_ACQUIRE);
        //确保了在这个屏障之后的所有读操作（以及依赖于这些读操作的写操作）
        if (!memory[position].used) {
            memory[position].used = 1;
            pthread_mutex_unlock(&memory[position].lock);
            printf("Allocated memory buffer %d\n", position);
            return position; // 返回分配的内存位置
        }
        pthread_mutex_unlock(&memory[position].lock);
    }
    return -1; // 没有可用的内存单元
}

void release_memory(int position) {
    if (position < 0 || position >= NUM_BUFFERS) {
        printf("Invalid memory buffer position %d\n", position);
        return;
    }
    pthread_mutex_lock(&memory[position].lock);
    // arm: ensure all writes are finished before other thread takes this memory
    __atomic_thread_fence(__ATOMIC_RELEASE);
    memory[position].used = 0;
    pthread_mutex_unlock(&memory[position].lock);
    printf("Released memory buffer %d\n", position);
}

void* thread_function(void* arg) {
    int allocated_position = allocate_memory();
    if (allocated_position != -1) {
        printf("Do something with memory buffer %d\n", allocated_position);


        // 模拟执行操作时的随机延迟
        unsigned int delay = rand() % 1000000; // 生成一个随机延迟（0到999999微秒）
        usleep(delay); // 以微秒为单位的延迟

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

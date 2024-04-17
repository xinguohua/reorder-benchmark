// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c 23-includeos.c  -o 23-includeos.bc （25，39）（26，36）
// Created by nsas2020 on 24-3-18.
//https://github.com/includeos/IncludeOS/pull/1926/files

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <assert.h>
const int VMXNET3_NUM_RX_DESC = 512; // 假设的接收描述符的数量
const int VMXNET3_RX_FILL = 100; // 假设的需要填充的数据包数量
const int MAX_PACKET_LEN = 1500; // 假设的最大数据包长度

// 假设的描述符结构体
struct Descriptor {
    int address; // 数据包地址
    int length; // 数据包长度
};

struct Descriptor descriptors[512];
int product_count;
int consumed_count = 0;

void* refill(void* arg) {
    if (consumed_count < product_count) {
        assert(descriptors[consumed_count % VMXNET3_NUM_RX_DESC].address == 1111);
        descriptors[consumed_count % VMXNET3_NUM_RX_DESC].address = 2222; // Example address
        descriptors[consumed_count % VMXNET3_NUM_RX_DESC].length = MAX_PACKET_LEN;
        consumed_count++;
        printf("Consumed: %d\n", consumed_count);
    }
}

void* receive_handler(void* arg){
    while (product_count < VMXNET3_RX_FILL) {
        int idx = product_count;
        descriptors[idx % VMXNET3_NUM_RX_DESC].address = 1111; // Example address
        descriptors[idx % VMXNET3_NUM_RX_DESC].length = MAX_PACKET_LEN;
        //  __arch_read_memory_barrier();
        product_count++;
        printf("Produced: %d\n", idx + 1);
    }
}

int main() {
    pthread_t producer_thread, consumer_thread;

    pthread_create(&producer_thread, NULL, refill, NULL);
    pthread_create(&consumer_thread, NULL, receive_handler, NULL);

    pthread_join(producer_thread, NULL);
    pthread_join(consumer_thread, NULL);

    return 0;
}


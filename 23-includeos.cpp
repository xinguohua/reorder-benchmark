// /usr/local/clang-4.0/bin/clang++ -emit-llvm -g -c  -std=c++14  23-includeos.cpp  -o 23-includeos.bc
// Created by nsas2020 on 24-3-18.
//https://github.com/includeos/IncludeOS/pull/1926/files

#include <iostream>
#include <vector>
#include <thread>
#include <atomic>
#include <cassert>

const int VMXNET3_NUM_RX_DESC = 512; // 假设的接收描述符的数量
const int VMXNET3_RX_FILL = 100; // 假设的需要填充的数据包数量
const int MAX_PACKET_LEN = 1500; // 假设的最大数据包长度

// 假设的描述符结构体
struct Descriptor {
    uintptr_t address; // 数据包地址
    uint32_t length; // 数据包长度
};

// 共享的环形缓冲区状态
struct RingState {
    std::vector<Descriptor> descriptors; // 描述符数组
    std::atomic<int> product_count; // 当前缓冲区内产品的数量

    RingState() : product_count(0), descriptors(VMXNET3_NUM_RX_DESC) {
        // 初始化描述符数组
    }
};

// 全局环形缓冲区状态
RingState ring;

// 生成者函数：填充环形缓冲区的描述符
void refill() {
    while (ring.product_count < VMXNET3_RX_FILL) {
        int i = ring.product_count % VMXNET3_NUM_RX_DESC;
        // 假设这里分配并填充了数据包
        ring.descriptors[i].address = reinterpret_cast<uintptr_t>(new char[MAX_PACKET_LEN]);
        ring.descriptors[i].length = MAX_PACKET_LEN;
        printf("2222");
        // 更新产品数量，表示新的数据包已经准备好
        ring.product_count++;
    }
}

// 消费者函数：处理环形缓冲区的数据包
void receive_handler() {
    int processed_count = 0; // 已处理的数据包计数
    while (processed_count < VMXNET3_RX_FILL) {
        if (ring.product_count > 0) {
            int i = processed_count % VMXNET3_NUM_RX_DESC;
            // 假设这里处理了数据包
            char* packet = reinterpret_cast<char*>(ring.descriptors[i].address);
            // 处理完毕后，释放数据包内存
            delete[] packet;
            ring.descriptors[i].address = 0;
            ring.descriptors[i].length = 0;
            printf("111");
            // 更新已处理的数据包计数
            processed_count++;
        }
    }
}

int main() {
    // 启动生成者（填充）和消费者（处理）线程
    std::thread producer_thread(refill);
    std::thread consumer_thread(receive_handler);

    // 等待线程完成
    producer_thread.join();
    consumer_thread.join();

    return 0;
}


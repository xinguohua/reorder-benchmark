///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  21-libfabric.c  -o 21-libfabric.bc
// Created by nsas2020 on 24-3-18.
//https://github.com/ofiwg/libfabric/pull/9370
//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// 模拟的 resp 结构体
typedef struct {
    int status;
} Resp;

// 获取指针的静态内联函数
static inline void* smr_get_ptr(void* base, uint64_t offset) {
    return (char*) base + offset;
}

// 用于模拟内存屏障的函数
static inline void memory_barrier() {
    // 根据你的平台和编译器，这里可能需要特定的实现
    // 例如，GCC 的 __sync_synchronize() 或 C11 的 stdatomic.h
    __sync_synchronize();
}

void smr_progress_cmd_atomic() {
    Resp* peer_smr;

    peer_smr = (Resp*)malloc(sizeof(Resp) * 4);
    int cmd_data = 2;

    // 模拟获取 resp 指针
    Resp* resp = (Resp*)smr_get_ptr(peer_smr, cmd_data);

    // 添加内存屏障来确保之前的内存操作完成
    //memory_barrier();

    // 更新 resp 状态
    resp->status = -1;
}

int main() {
    smr_progress_cmd_atomic(); // 模拟第二个 Resp 的状态更新
    return 0;
}

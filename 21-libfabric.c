///usr/local/clang-4.0/bin/clang -emit-llvm -g -c  21-libfabric.c  -o 21-libfabric.bc
// Created by nsas2020 on 24-3-18.
//https://github.com/ofiwg/libfabric/pull/9370
//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

void smr_progress_cmd_atomic(void* peer_smr, uint64_t cmd_data, int err) {
    Resp* resp;

    // 模拟获取 resp 指针
    resp = (Resp*)smr_get_ptr(peer_smr, cmd_data);

    // 添加内存屏障来确保之前的内存操作完成
    //memory_barrier();

    // 更新 resp 状态
    resp->status = -err;
}

int main() {
    // 简单的测试
    Resp* peer_smr = (Resp*)malloc(sizeof(Resp) * 2); // 假设有两个 Resp 结构体
    int err = 1; // 模拟的错误码

    smr_progress_cmd_atomic(peer_smr, sizeof(Resp), err); // 模拟第二个 Resp 的状态更新

    printf("Resp status: %d\n", peer_smr[1].status); // 应该输出 "-1"

    free(peer_smr);
    return 0;
}

// https://github.com/open-mpi/ompi/pull/5536
// Created by nsas2020 on 24-7-16.
//  /usr/local/clang-4.0/bin/clang++ -std=c++11 -emit-llvm -g -c 26-ompi.cpp -o 26-ompi.bc
//  /usr/local/clang-4.0/bin/clang++ -std=c++11 -S -emit-llvm -g 26-ompi.cpp -o 26-ompi.ll
#include <pthread.h>
#include <unistd.h>
#include <atomic>
#include <assert.h>

// 定义头结构
class mca_btl_vader_fbox_hdr_t {
public:
    uint32_t size;
    uint16_t tag;
    uint16_t seq;
    mca_btl_vader_fbox_hdr_t(uint16_t t, uint16_t s, uint32_t sz) : tag(t), seq(s), size(sz) {}
    mca_btl_vader_fbox_hdr_t() : tag(0), seq(0), size(0) {}
};

// 写内存屏障
static inline void opal_atomic_wmb(void) {
    std::atomic_thread_fence(std::memory_order_release);
}

// 读内存屏障
static inline void opal_atomic_rmb(void) {
    std::atomic_thread_fence(std::memory_order_acquire);
}

// 全局头结构
mca_btl_vader_fbox_hdr_t* global_hdr;

// 设置头结构的值并插入写内存屏障
static inline void mca_btl_vader_fbox_set_header(uint16_t tag,
                                                 uint16_t seq, uint32_t size)
{
    mca_btl_vader_fbox_hdr_t tmp(tag, seq, size);
    global_hdr = &tmp;
    opal_atomic_wmb();
}

// 读取头结构的值并插入读内存屏障
static inline void mca_btl_vader_fbox_read_header()
{
    if (global_hdr){
        assert(global_hdr->size != 0);
    }
}



// 写操作线程函数
void* writer_thread(void* arg) {
    for (int i = 0; i < 5; ++i) {
        mca_btl_vader_fbox_set_header(1, i, 1024);
        sleep(1); // 模拟写操作的间隔
    }
    return NULL;
}

// 读操作线程函数
void* reader_thread(void* arg) {
    for (int i = 0; i < 5; ++i) {
        mca_btl_vader_fbox_read_header();
        sleep(1); // 模拟读操作的间隔
    }
    return NULL;
}

// 主函数
int main() {
    pthread_t writer, reader;
    pthread_create(&writer, NULL, writer_thread, NULL);
    pthread_create(&reader, NULL, reader_thread, NULL);
    pthread_join(writer, NULL);
    pthread_join(reader, NULL);
    return 0;
}
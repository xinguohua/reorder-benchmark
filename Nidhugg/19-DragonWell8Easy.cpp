//  /usr/local/clang-4.0/bin/clang++ -emit-llvm -g -c -std=c++11 19-DragonWell8Easy.cpp  -o 19-DragonWell8.bc
// Created by nsas2020 on 24-3-18.
//https://bugs.openjdk.org/browse/JDK-8154750
//clang++ -emit-llvm -g -c -std=c++11 -fno-use-cxa-atexit 19-DragonWell8Easy.cpp -o 19-DragonWell8.bc
//        root@6a439597c322:/target# llvm-dis-6.0 19-DragonWell8.bc -o 19-DragonWell8.ll
//        root@6a439597c322:/target# time nidhugg -arm 19-DragonWell8.ll
//        Error: ERROR: Call to external function _ZNSt8ios_base4InitC1Ev is not supported under POWER.

#include <pthread.h>
#include <iostream>


typedef struct PackageEntry {
    char* name;
    struct PackageEntry* nextEntry;
} PackageEntry;

struct PackageEntryTable {
    PackageEntry* buckets[10]{};
//    pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

    PackageEntryTable() {
        for (int i = 0; i < 10; ++i) {
            buckets[i] = nullptr;
        }
    }
};

// 全局变量，代表包表和其互斥锁，简化示例不包括初始化互斥锁的代码
//pthread_mutex_t globalTableLock = PTHREAD_MUTEX_INITIALIZER;

// 确保PackageEntryTable被创建且仅被创建一次
PackageEntryTable* getOrCreatePackageEntryTable(struct PackageEntryTable* globalPackageTable) {
    // Lazily create the package entry table at first request.
    // Lock-free access requires load_ptr_acquire.
    // PackageEntryTable* packages = load_ptr_acquire(&_packages);
    if (globalPackageTable == nullptr) {
        // pthread_mutex_lock(&globalTableLock);
        if (globalPackageTable == nullptr) {
            globalPackageTable = new PackageEntryTable();
            // Ensure _packages is stable, since it is examined without a lock
            // OrderAccess::release_store_ptr(&_packages, packages);
        }
        //  pthread_mutex_unlock(&globalTableLock);
    }
    return globalPackageTable;
}



void* threadRoutine(void* arg) {
    // 调用getOrCreatePackageEntryTable，每个线程都尝试获取或创建全局的PackageEntryTable实例
    struct PackageEntryTable* globalPackageTable = nullptr;
    PackageEntryTable* table = getOrCreatePackageEntryTable(globalPackageTable);
    //printf("Thread %ld has accessed the PackageEntryTable at address %p\n", (long)pthread_self(), (void*)table);

    return nullptr;
}

// 示例使用
int main() {
    const int NUM_THREADS = 5;
    pthread_t threads[NUM_THREADS];

    // 创建多个线程，每个都尝试获取或创建PackageEntryTable实例
    for (unsigned long & thread : threads) {
        if (pthread_create(&thread, nullptr, threadRoutine, nullptr) != 0) {
           // perror("Failed to create thread");
            return 1;
        }
    }

    // 等待所有线程完成
    for (unsigned long thread : threads) {
        pthread_join(thread, nullptr);
    }
}

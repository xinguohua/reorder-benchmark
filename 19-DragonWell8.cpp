/////usr/local/clang-4.0/bin/clang++ -emit-llvm -g -c  -std=c++14 19-DragonWell8.cpp  -o 19-DragonWell8.bc
//// Created by nsas2020 on 24-3-18.
////https://bugs.openjdk.org/browse/JDK-8154750
////
//#include <iostream>
//#include <vector>
//#include <mutex>
//
//
//#include <iostream>
//#include <vector>
//#include <mutex>
//#include <string>
//#include <thread>
//
//class PackageEntry {
//public:
//    std::string name; // 包名
//    PackageEntry* nextEntry; // 指向下一个包的指针
//
//    PackageEntry(std::string name) : name(name), nextEntry(nullptr) {}
//};
//
//class PackageEntryTable {
//private:
//    std::vector<PackageEntry*> buckets; // 存储包条目的向量
//public:
//    static const int _packagetable_entry_size = 10; // 假设有10个桶
//
//    PackageEntryTable() {
//        buckets.resize(_packagetable_entry_size, nullptr);
//    }
//
//    ~PackageEntryTable() {
//        // 清理资源
//        for (auto& entry : buckets) {
//            while (entry != nullptr) {
//                PackageEntry* temp = entry;
//                entry = entry->nextEntry;
//                delete temp;
//            }
//        }
//    }
//
//    int table_size() const {
//        return buckets.size();
//    }
//
//    PackageEntry* bucket(int i) const {
//        return buckets[i];
//    }
//
//    void addPackageEntry(std::string packageName) {
//        int index = std::hash<std::string>{}(packageName) % _packagetable_entry_size;
//        PackageEntry* newEntry = new PackageEntry(packageName);
//        newEntry->nextEntry = buckets[index];
//        buckets[index] = newEntry;
//    }
//};
//
//class ClassLoaderData {
//private:
//    PackageEntryTable* _packages;
//    std::mutex metaspace_lock; // 用于模拟原始代码中的锁
//
//public:
//    ClassLoaderData() : _packages(nullptr) {}
//    ~ClassLoaderData() {
//        delete _packages;
//    }
//
//    void packages_do(void (*f)(PackageEntry*)) {
//        //  PackageEntryTable* packages = load_ptr_acquire(&_packages);
//        //  if (packages != NULL) {
//        //   for (int i = 0; i < packages->table_size(); i++) {
//        //      for (PackageEntry* entry = packages->bucket(i);
//        if (_packages != nullptr) {
//            for (int i = 0; i < _packages->table_size(); i++) {
//                for (PackageEntry* entry = _packages->bucket(i); entry != nullptr; entry = entry->nextEntry) {
//                    f(entry);
//                }
//            }
//        }
//    }
//
//    PackageEntryTable* packages() {
//        // Lazily create the package entry table at first request.
//        //  lock-free access requires load_ptr_acquire.
//        //  PackageEntryTable* packages = load_ptr_acquire(&_packages);
//        // if (packages == NULL) {
//        if (_packages == nullptr) {
//            std::lock_guard<std::mutex> lock(metaspace_lock);
//            // Check if _packages got allocated while we were waiting for this lock.
//            //  // Check if _packages got allocated while we were waiting for this lock.
//            //    if ((packages = _packages) == NULL) {
//            //      packages = new PackageEntryTable(PackageEntryTable::_packagetable_entry_size);
//            //      // Ensure _packages is stable, since it is examined without a lock
//            //      OrderAccess::release_store_ptr(&_packages, packages);
//            //    }
//            if (_packages == nullptr) {
//                _packages = new PackageEntryTable();
//            }
//        }
//        return _packages;
//    }
//};
//
//
//void printPackage(PackageEntry* entry) {
//    std::cout << "Package name: " << entry->name << std::endl;
//}
//
//int main() {
//    ClassLoaderData data;
//    std::vector<std::thread> threads;
//
//    // Creating threads for adding packages
//    threads.emplace_back([&data]() { data.packages()->addPackageEntry("com.example.package1"); });
//    threads.emplace_back([&data]() { data.packages()->addPackageEntry("com.example.package2"); });
//    threads.emplace_back([&data]() { data.packages()->addPackageEntry("com.example.package3"); });
//
//    // Wait for package addition to complete
//    for (auto& thread : threads) {
//        thread.join();
//    }
//
//    // Clearing the threads vector to reuse for packages_do
//    threads.clear();
//
//    // Creating a thread for iterating over all package entries
//    threads.emplace_back([&data]() { data.packages_do(printPackage); });
//
//    // Wait for the package_do thread to complete
//    for (auto& thread : threads) {
//        thread.join();
//    }
//
//    return 0;
//}
/////usr/local/clang-4.0/bin/clang++ -emit-llvm -g -c -std=c++14 5-StackOverFlow.cpp -o 5-StackOverFlow.bc
//// Created by nsas2020 on 24-3-15.
////http://stackoverflow:com/questions/16159203/
////
//#include <iostream>
//#include <thread>
//#include <mutex>
//#include <memory>
//
//using namespace std;
//
//class Point {
//public:
//    int x, y;
//    Point(int x, int y) : x(x), y(y) {}
//};
//
//class A {
//public:
//    static unique_ptr<Point> currentPos;
//    static mutex mtx;
//
//    static void f() {
//        lock_guard<mutex> guard(mtx);
//        if (currentPos->x + 1 != currentPos->y) {
//            cout << currentPos->x << "------- " << currentPos->y << endl;
//            exit(1);
//        }
//    }
//
//    static void threadFunction() {
//        while (true) {
//            f();
//        }
//    }
//};
//
//unique_ptr<Point> A::currentPos = make_unique<Point>(1, 2);
//mutex A::mtx;
//
//int main() {
//    thread t(A::threadFunction);
//
//    while (true) {
//        lock_guard<mutex> guard(A::mtx);
//        int newX = A::currentPos->x + 1;
//        int newY = A::currentPos->y + 1;
//        A::currentPos = make_unique<Point>(newX, newY);
//    }
//
//    t.join(); // This will never be reached
//    return 0;
//}
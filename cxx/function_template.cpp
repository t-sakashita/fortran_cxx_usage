#include <iostream>
using namespace std;

template <class T>
T quadratic(T x) {
  return 3 * x * x + 2;
}

int main() {
  cout << "int: " << quadratic(2) << endl; // 整数型
  cout << "float: " << quadratic(2.0) << endl;  // 単精度
  cout << "double: " << quadratic((double)2.0) << endl; // 倍精度
}

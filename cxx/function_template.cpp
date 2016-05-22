#include <iostream>

template <class T>
T quadratic(T x) {
  return 3 * x * x + 2;
}

int main() {
  std::cout << "int: " << quadratic<int>(2) << std::endl; // 整数型
  std::cout << "float: " << quadratic<float> (2.0) << std::endl;  // 単精度
  std::cout << "double: " << quadratic<double> (2.0) << std::endl; // 倍精度
}

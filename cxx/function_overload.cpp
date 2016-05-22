#include <iostream>

// 整数型の関数
int quadratic(int x) {
  return 3 * x * x + 2;
}

// 単精度型の関数
float quadratic(float x) {
  return 3. * x * x + 2.;
}

// 倍精度型の関数
double quadratic(double x) {
  return 3. * x * x + 2.;
}

int main() {
  std::cout << "int: " << quadratic(2) << std::endl; // 整数型
  std::cout << "float: " << quadratic((float)2.0) << std::endl;  // 単精度
  std::cout << "double: " << quadratic((double)2.0) << std::endl; // 倍精度
}

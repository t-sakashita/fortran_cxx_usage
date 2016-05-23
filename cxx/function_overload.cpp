#include <iostream>
using namespace std;

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
  cout << "int: " << quadratic(2) << endl; // 整数型
  cout << "float: " << quadratic((float)2.0) << endl;  // 単精度
  cout << "double: " << quadratic((double)2.0) << endl; // 倍精度
}

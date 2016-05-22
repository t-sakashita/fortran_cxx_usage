// factorial_constexpr.cpp
#include <iostream>
using namespace std;

constexpr int factorial(int n) {
  return n == 1 ? 1 : n * factorial(n-1);
}

int main() {
  cout << factorial(10) << endl;
}


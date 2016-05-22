// factorial_template.cpp
#include <iostream>
using namespace std;

template<int N>
struct factorial {
  static const int value = N * factorial<N-1>::value;
};

template<>
struct factorial<0> {
  static const int value = 1;
};

int main() {
  cout << factorial<10>::value << endl;
}

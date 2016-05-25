// factorial_template.cpp
#include <iostream>
using namespace std;

template<int N>
class factorial {
public:
  static const int value = N * factorial<N-1>::value;
};

// N=0の場合のテンプレート特殊化
template<>
class factorial<0> {
public:
  static const int value = 1;
};

int main() {
  cout << factorial<10>::value << endl;
}

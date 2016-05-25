#include <iostream>
#include <cmath>
using namespace std;

template<class T>
class user_func {
public:
  user_func(T a_in, T b_in) : a(a_in), b(b_in) {}
  
  T operator() (T x) const {
    return a * cos(x) + log(b*x);
  }
private:
  T a, b;
};

int main() {
  user_func<double> f(1.0, 2.0);
  cout << f(3.) << endl;
  user_func<float> g(1.0, 2.0);
  cout << g(3.) << endl;
}

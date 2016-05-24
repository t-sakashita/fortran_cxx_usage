#include <iostream>
#include <cmath>
using namespace std;

class user_func {
public:
  user_func(double a_in, double b_in) : a(a_in), b(b_in) {}
  
  double operator() (double x) const {
    return a * cos(x) + log(b*x);
  }
private:
  double a, b;
};

int main() {
  user_func f(1.0, 2.0);
  cout << f(0.2) << endl;
}

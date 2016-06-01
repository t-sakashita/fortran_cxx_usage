#include <cmath>

class user_functor1 {
public:
  user_functor1(double a_in, double b_in) : a(a_in), b(b_in) {}

  double get_a() const { return a; }
  double get_b() const { return b; }
  
  double operator() (double x) const {
    return a * cos(x) + log(x+b);
  }
private:
  double a, b;
};

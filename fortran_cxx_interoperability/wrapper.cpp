#include <iostream>
#include <cmath>

using namespace std;

class user_functor {
public:
  user_functor(double a_in, double b_in) : a(a_in), b(b_in) {}
  
  double operator() (double x) const {
    return a * cos(x) + log(x+b);
  }
private:
  double a, b;
};

/* C wrapper interfaces to C++ routines */
extern "C" {
  
  //struct struct_user_functor {
  //  void* ptr;
  //};
  
  user_functor* user_functor_construct(double a, double b) {
    std::cout << "a=" << a << " b=" << b << std::endl;
    return new user_functor(a, b);
  }
  double user_functor_eval(user_functor* This, double x) {
    std::cout << "x=" << x << std::endl;
    return (*This)(x);
  }
  void user_functor_destruct(user_functor* This) {
    delete This;
  }

}


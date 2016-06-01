#include <iostream>
#include "user_functor1.hpp"

/* C wrapper interfaces to C++ routines */
extern "C" {
  
  user_functor1* user_functor1_construct(double a, double b) {
    std::cout << "a=" << a << " b=" << b << std::endl;
    return new user_functor1(a, b);
  }
  double user_functor1_eval(user_functor1* This, double x) {
    std::cout << "read_a=" << This->get_a() << " read_b=" << This->get_b() << std::endl;
    std::cout << "x=" << x << std::endl;
    return (*This)(x);
  }
  void user_functor1_destruct(user_functor1* This) {
    delete This;
  }

}

#include <iostream>
#include "user_functor2.hpp"

/* C wrapper interfaces to C++ routines */

extern "C" {

  user_functor2* user_functor2_construct(int m) {
    std::cout << "m=" << m << std::endl;
    return new user_functor2(m);
  }
  double user_functor2_eval(user_functor2* This, double x) {
    std::cout << "read_m=" << This->get_m() << std::endl;
    std::cout << "x=" << x << std::endl;
    return (*This)(x);
  }
  void user_functor2_destruct(user_functor2* This) {
    delete This;
  }

}

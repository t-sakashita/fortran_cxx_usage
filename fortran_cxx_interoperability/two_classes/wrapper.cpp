#include <iostream>
#include <cmath>

using namespace std;

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

class user_functor2 {
public:
  user_functor2(int m_in) : m(m_in) {}

  int get_m() const { return m; }
  
  double operator() (double x) const {
    return m * sin(x);
  }
private:
  int m;
};

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

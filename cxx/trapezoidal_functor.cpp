#include <iostream>
#include <cmath>

class functor {
public:
  virtual double operator()(double x) const = 0;
};

class quadratic : public functor {
public:
  double operator() (double x) const {
    return 3 * x * x + 2;
  }
};

class cosine : public functor {
public:
  double operator() (double x) const {
    return std::cos(x);
  }
};

class user_func {
public:
  user_func(double a_in, double b_in) : a(a_in), b(b_in) {}
  
  double operator() (double x) const {
    return a * cos(x) + log(b*x);
  }
private:
  double a, b;
};

template <typename F>
double integrate(F f, double x_min, double x_max, int n, bool verbose) {
  double sum = 0.;
  double h = (x_max - x_min) / n;
  for (int i=1; i<n; ++i) {
    double x = x_min + i * h;
    double x2 = x_min + (i+1) * h;
    sum += 0.5 * (f(x) + f(x2));
    if (verbose) std::cout << "x=" << x << " partial_sum=" << sum * h << std::endl;
  }
  return sum * h;
}

int main() {
  integrate(user_func(1.0, 2.0), 0., 1., 20000, true);

  integrate(cosine(), 0., 1., 20000, true);
}

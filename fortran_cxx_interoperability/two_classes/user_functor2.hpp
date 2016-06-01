#include <cmath>

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

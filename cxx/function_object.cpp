#include <iostream>
#include <cmath>
using namespace std;

class quadratic {
public:
  double operator() (double x) const {
    return 3 * x * x + 2;
  }
};

int main() {
  quadratic f;
  cout << "f=" << f(0.2) << endl;
}

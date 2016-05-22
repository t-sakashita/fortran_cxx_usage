#include <iostream>
using namespace std;

template <bool Cond, class Then, class Else>
struct IF;

template <class Then,class Else>
struct IF<true,Then,Else>{
  typedef Then type; // Thenをtypeと定義する。
};

template <class Then,class Else>
struct IF<false,Then,Else>{
  typedef Else type; // Elseをtypeと定義する。
};

// テンプレート引数で整数Nに対して、Nが偶数（奇数）だったら、スタティック変数valueにtrue(false)が設定される。
template <int N>
struct is_even {
  static const bool value = (N % 2 == 0);
};

// テンプレート引数で整数Nに対して、Nが奇数（偶数）だったら、スタティック変数valueにtrue(false)が設定される。
template <int N>
struct is_odd {
  static const bool value = !is_even<N>::value;
};

// クラスAの定義
struct A {
  static const int val = 10;
  static void stat_func() { cout << "A's stat_func is called!" << endl; }
  void func(){ cout << "A's func is called!" << endl; }
};

// クラスBの定義
struct B {
  static const int val = 20;
  static void stat_func() { cout << "B's stat_func is called!" << endl; }
  void func() { cout << "B's func is called!" << endl; }
};

#define NUM 10
int main() {
  // テンプレート引数Condにtrueを入れた場合
  std::cout << IF<true,A,B>::type::val << std::endl;
  IF<true,A,B>::type::stat_func();			
  IF<true,A,B>::type Obj1;
  Obj1.func();

  // テンプレート引数Condにfalseを代入する場合。
  std::cout << IF<false,A,B>::type::val << std::endl;
  IF<false,A,B>::type::stat_func();			
  IF<false,A,B>::type Obj2;
  Obj2.func();

  // テンプレート引数Condは偶奇。
  std::cout << IF<is_even<3>::value,A,B>::type::val << std::endl;
  IF<is_even<3>::value,A,B>::type::stat_func();			
  IF<is_even<3>::value,A,B>::type Obj3;
  Obj3.func();

  // テンプレート引数Condは偶奇。
  std::cout << IF<is_even<NUM>::value,A,B>::type::val << std::endl;
  IF<is_even<NUM>::value,A,B>::type::stat_func();			
  IF<is_even<NUM>::value,A,B>::type Obj4;
  Obj4.func();
}

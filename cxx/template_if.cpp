#include <iostream>
using namespace std;

// テンプレートIFの宣言
template <bool Cond, class Then, class Else>
class IF;

// テンプレートIFの部分特殊化：Cond=trueの場合。他のテンプレートパラメータThenとElseはそのまま渡される。
template <class Then,class Else>
class IF<true,Then,Else> {
public:
  typedef Then ret; // Thenをtypeと定義する。
};

// テンプレートIFの部分特殊化：Cond=falseの場合。他のテンプレートパラメータThenとElseはそのまま渡される。
template <class Then,class Else>
class IF<false,Then,Else> {
public:
  typedef Else ret; // Elseをtypeと定義する。
};

// クラスAの定義
class A {
public:
  static const int val = 10;
  static void stat_func() { cout << "A's stat_func is called!" << endl; }
  void func(){ cout << "A's func is called!" << endl; }
};

// クラスBの定義
class B {
public:
  static const int val = 20;
  static void stat_func() { cout << "B's stat_func is called!" << endl; }
  void func() { cout << "B's func is called!" << endl; }
};

int main() {
  // テンプレート引数Condにtrueを入れた場合
  std::cout << IF<true,A,B>::ret::val << std::endl;
  IF<true,A,B>::ret::stat_func();			
  IF<true,A,B>::ret Obj;
  Obj.func();

  // テンプレート引数Condにfalseを代入する場合。
  std::cout << IF<false,A,B>::ret::val << std::endl;
  IF<false,A,B>::ret::stat_func();			
  IF<false,A,B>::ret Obj2;
  Obj2.func();
}

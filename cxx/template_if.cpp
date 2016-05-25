#include <iostream>
using namespace std;

template <bool Cond, class Then, class Else>
class IF;

template <class Then,class Else>
class IF<true,Then,Else> {
public:
  typedef Then ret;
};

template <class Then,class Else>
class IF<false,Then,Else> {
public:
  typedef Else ret;
};

class A {	// クラスAで定義されているもの
public:
  static const int val = 10;
  static void statFunc() { cout << "A...." << endl; }
  void func(){ cout << "A!" << endl; }	//インスタンス化して利用できるinlineメンバ関数
};

class B {	// クラスBで定義されているもの
public:
  static const int val = 20;
  static void statFunc() { cout << "B...." << endl; }
  void func() { cout << "B!" << endl; }	//インスタンス化して利用できるinlineメンバ関数
};

int main() {
  //条件分岐の対象クラスをA,Bに設定して、テンプレート引数にtrueを入れた場合
  std::cout << IF<true,A,B>::ret::val << std::endl;
  IF<true,A,B>::ret::statFunc();			
  IF<true,A,B>::ret Obj;
  Obj.func();

  //条件分岐の対象クラスをA,Bに設定して、テンプレート引数にfalseを入れた場合
  std::cout << IF<true,A,B>::ret::val << std::endl;
  IF<true,A,B>::ret::statFunc();			
  IF<true,A,B>::ret Obj2;
  Obj2.func();
}

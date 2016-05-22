#include <iostream>
using namespace std;

template <bool Cond, class Then, class Else>
struct IF;

template <class Then,class Else>
struct IF<true,Then,Else>{
  typedef Then ret;
};

template <class Then,class Else>
struct IF<false,Then,Else>{
  typedef Else ret;
};

struct A{	// クラスAで定義されているもの
  static const int val = 10;
  static void statFunc() { cout << "A...." << endl; }
  void func(){ cout << "A!" << endl; }	//インスタンス化して利用できるinlineメンバ関数
};

struct B{	// クラスBで定義されているもの
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
  IF<true,A,B>::ret Obj;
  Obj.func();
}

module user_functor1_mod
  use base_functor_mod
  use iso_c_binding
  implicit none
  type, extends(base_functor_type) :: user_functor1_type
     type(c_ptr) :: ptr
   contains
     procedure, pass(this) :: eval => user_functor1_eval
  end type user_functor1_type

  interface
     function user_functor1_construct_c (a, b) result(ptr) bind(c,name="user_functor1_construct")
       import
       real(8), value, intent(in) :: a, b
       type(c_ptr) :: ptr
     end function user_functor1_construct_c
     subroutine user_functor1_destruct_c (ptr) bind(c,name="user_functor1_destruct")
       import
       type(c_ptr), value, intent(in) :: ptr
     end subroutine user_functor1_destruct_c
     function user_functor1_eval_c (ptr, x) result(y) bind(c,name="user_functor1_eval")
       use iso_c_binding
       import
       type(c_ptr), value, intent(in) :: ptr
       real(8), value, intent(in) :: x
       real(8) :: y
     end function user_functor1_eval_c
  end interface
  
  interface construct
     module procedure user_functor1_construct
  end interface construct
  
  interface destruct
     module procedure user_functor1_destruct
  end interface destruct
  
contains
  
  subroutine user_functor1_construct(this,a,b)
    type(user_functor1_type), intent(out) :: this
    real(8), intent(in) :: a, b
    this%ptr = user_functor1_construct_c(a,b)
  end subroutine user_functor1_construct
  
  subroutine user_functor1_destruct(this)
    type(user_functor1_type), intent(inout) :: this
    call user_functor1_destruct_c(this%ptr)
    this%ptr = c_null_ptr
  end subroutine user_functor1_destruct
  
  function user_functor1_eval(this,x) result(y)
    class(user_functor1_type), intent(in) :: this
    real(8), intent(in) :: x
    real(8) :: y
    print *,"x0=", x
    y = user_functor1_eval_c(this%ptr, x)
  end function user_functor1_eval
  
end module user_functor1_mod

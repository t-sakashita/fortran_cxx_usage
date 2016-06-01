module user_functor2_mod
  use base_functor_mod
  use iso_c_binding
  implicit none
  type, extends(base_functor_type) :: user_functor2_type
     type(c_ptr) :: ptr
   contains
     procedure, pass(this) :: eval => user_functor2_eval
  end type user_functor2_type

  interface
     function user_functor2_construct_c (m) result(ptr) bind(c,name="user_functor2_construct")
      import
      integer, value, intent(in) :: m
      type(c_ptr) :: ptr
    end function user_functor2_construct_c
    subroutine user_functor2_destruct_c (ptr) bind(c,name="user_functor2_destruct")
      import
      type(c_ptr), value, intent(in) :: ptr
    end subroutine user_functor2_destruct_c    
    function user_functor2_eval_c (ptr, x) result(y) bind(c,name="user_functor2_eval")
      use iso_c_binding
      import
      type(c_ptr), value, intent(in) :: ptr
      real(8), value, intent(in) :: x
      real(8) :: y
    end function user_functor2_eval_c
 end interface

 interface construct
    module procedure user_functor2_construct
 end interface construct
 
  interface destruct
    module procedure user_functor2_destruct
 end interface destruct
 
contains

  subroutine user_functor2_construct(this,m)
    type(user_functor2_type), intent(out) :: this
    integer, intent(in) :: m
    this%ptr = user_functor2_construct_c(m)
  end subroutine user_functor2_construct
  
  subroutine user_functor2_destruct(this)
    type(user_functor2_type), intent(inout) :: this
    call user_functor2_destruct_c(this%ptr)
    this%ptr = c_null_ptr
  end subroutine user_functor2_destruct
  
  function user_functor2_eval(this,x) result(y)
    class(user_functor2_type), intent(in) :: this
    real(8), value, intent(in) :: x
    real(8) :: y
    print *,"x0=", x
    y = user_functor2_eval_c(this%ptr, x)
  end function user_functor2_eval
  
end module user_functor2_mod

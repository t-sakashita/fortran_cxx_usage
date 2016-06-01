module base_functor_mod
  implicit none
  type, abstract :: base_functor_type
   contains
     procedure(base_functor_eval), deferred, pass(this) :: eval
  end type base_functor_type

  abstract interface
     real(8) function base_functor_eval(this, x)
       import :: base_functor_type
       class(base_functor_type), intent(in) :: this
       real(8), value, intent(in) :: x
     end function base_functor_eval
  end interface

end module base_functor_mod


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
     function user_functor1_construct_c (a, b) result(ptr) bind(c,name="user_functor_construct")
      import
      real(8), value, intent(in) :: a, b
      type(c_ptr) :: ptr
    end function user_functor1_construct_c
    subroutine user_functor1_destruct_c (ptr) bind(c,name="user_functor_destruct")
      import
      type(c_ptr), value, intent(in) :: ptr
    end subroutine user_functor1_destruct_c    
    function user_functor1_eval_c (ptr, x) result(y) bind(c,name="user_functor_eval")
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
    real(8), value, intent(in) :: x
    real(8) :: y
    print *,"x0=", x
    y = user_functor1_eval_c(this%ptr, x)
  end function user_functor1_eval
  
end module user_functor1_mod


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
     function user_functor2_construct_c (a, b) result(ptr) bind(c,name="user_functor_construct")
      import
      real(8), value, intent(in) :: a, b
      type(c_ptr) :: ptr
    end function user_functor2_construct_c
    subroutine user_functor2_destruct_c (ptr) bind(c,name="user_functor_destruct")
      import
      type(c_ptr), value, intent(in) :: ptr
    end subroutine user_functor2_destruct_c    
    function user_functor2_eval_c (ptr, x) result(y) bind(c,name="user_functor_eval")
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

  subroutine user_functor2_construct(this,a,b)
    type(user_functor2_type), intent(out) :: this
    real(8), intent(in) :: a, b
    this%ptr = user_functor2_construct_c(a,b)
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

module integration_mod
  use base_functor_mod
  implicit none

contains

  subroutine integrate_trapezoid(this, xmin, xmax, steps, res)
    class(base_functor_type) :: this
    real(8), intent(in) :: xmin, xmax
    integer, intent(in) :: steps
    real(8), intent(out) :: res

    integer :: i
    real(8) :: x, dx
    
    dx = (xmax - xmin) / steps
    res = (this%eval(xmin) + this%eval(xmax)) / 2

    do i = 2, steps
       x = xmin + (i-1) * dx
       res = res + this%eval(x)
    enddo
    
    res = res * dx
  end subroutine integrate_trapezoid
end module integration_mod


program test_integrate
  use integration_mod
  use user_functor1_mod
  use user_functor2_mod
  implicit none

  type(user_functor1_type) :: this, that
  type(user_functor2_type) :: this2

  real(8) :: xmin, xmax, s
  integer :: n

  xmin = 1.d0
  xmax = 10.d0
  n = 10
  
  call construct(this, 0.d0, 5.d0)
  call integrate_trapezoid(this, xmin, xmax, n, s)
  write(*,*) 'Result: ', s
  call destruct(this)

  call construct(that, 1.d0, 10.d0)
  call integrate_trapezoid(that, xmin, xmax, n, s)
  write(*,*) 'Result: ', s
  call destruct(that)

  call construct(this2, 1.d0, 10.d0)
  call integrate_trapezoid(this2, xmin, xmax, n, s)
  write(*,*) 'Result: ', s
  call destruct(this2)
  
end program test_integrate


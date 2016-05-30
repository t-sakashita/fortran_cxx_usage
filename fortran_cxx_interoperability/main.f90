
module user_functor_mod
  use, intrinsic :: iso_c_binding, only: c_int, c_ptr, c_null_ptr
  implicit none
  type user_functor_type
    private
    type(c_ptr) :: object = c_null_ptr
  end type user_functor_type
  interface
    function user_functor_construct_c (a, b) result(this) bind(c,name="user_functor_construct")
      import
      real(8), value, intent(in) :: a, b
      type(c_ptr) :: this
    end function user_functor_construct_c
    subroutine user_functor_destruct_c (this) bind(c,name="user_functor_destruct")
      import
      type(c_ptr), value :: this
    end subroutine user_functor_destruct_c
    function user_functor_eval_c (this, x) result(y) bind(c,name="user_functor_eval")
      import
      type(c_ptr), value, intent(in) :: this
      real(8), value, intent(in) :: x
      real(8) :: y
    end function user_functor_eval_c
  end interface
  interface construct
    module procedure user_functor_construct
  end interface construct
  interface destruct
    module procedure user_functor_destruct
  end interface destruct
  interface eval
    module procedure user_functor_eval
  end interface eval

contains
! fortran wrapper routines to interface c wrappers
  subroutine user_functor_construct(this,a,b)
    type(user_functor_type), intent(out) :: this
    real(8) :: a, b
    this%object = user_functor_construct_c(a,b)
  end subroutine user_functor_construct
  subroutine user_functor_destruct(this)
    type(user_functor_type), intent(inout) :: this
    call user_functor_destruct_c(this%object)
    this%object = c_null_ptr
  end subroutine user_functor_destruct
  
  function user_functor_eval(this, x) result(y)
    type(user_functor_type), intent(in) :: this
    real(8), value, intent(in) :: x
    real(8) :: y
    print *,"x0=", x
    y = user_functor_eval_c(this%object, x)
  end function user_functor_eval
end module user_functor_mod


module user_func_mod_orig
  implicit none
  real(8), private :: a, b
  public

contains
  
  subroutine user_func_initialize(a_in, b_in)
    implicit none
    real(8), intent(in) :: a_in, b_in
    a = a_in
    b = b_in
  end subroutine user_func_initialize
  
  real(8) function user_func(x)
    real(8), intent(in) :: x
    user_func = a * cos(x) + log(x)
  end function user_func
  
end module user_func_mod_orig


module integrate_mod

contains

  real(8) function integrate(f, x_min, x_max)
    implicit none
    interface
       real(8) function f(x)
         real(8), intent(in) :: x
       end function f
    end interface
    integer :: i, n
    real(8), intent(in) :: x_min, x_max
    real(8) :: h, s
    real(8) :: x
    n = 20000
    h = (x_max - x_min) / n
    s = 0.d0
    do i=0, n-1
       x = x_min + i * h
       s = s + 0.5d0 * (f(x) + f(x+h))
       print *, "i=",i," partial_sum=", s * h
    enddo
    integrate = s * h
  end function integrate
  
end module integrate_mod


program main
  use user_functor_mod
  use user_func_mod_orig
  use integrate_mod
  implicit none
  real(8) :: s
  type(user_functor_type) :: t

  call user_functor_construct(t, 1d0, 2d0)
  print *, user_functor_eval(t, 23.d0)
  !  s = integrate(user_func_eval, 1.d0, 2.d0)
  !  print *, "s=", s
  call user_functor_destruct(t)
end program main


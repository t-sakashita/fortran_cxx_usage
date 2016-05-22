! user_function.f90
module user_func_mod
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
    user_func = a * cos(x) + log(b*x)
  end function user_func
  
end module user_func_mod

program main
  use user_func_mod
  implicit none
  
  call user_func_initialize(1d0, 2d0)
  print *, user_func(10.d0)
end program main


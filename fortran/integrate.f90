! integrate.f90
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

module integrate_mod
contains  
  real(8) function integrate(f, x_min, x_max, n)
    implicit none
    interface
       real(8) function f(x)
         real(8), intent(in) :: x
       end function f
    end interface
    integer :: i, n
    real(8), intent(in) :: x_min, x_max
    real(8) :: x, dx, s
    dx = (x_max - x_min) / n
    s = 0.d0
    do i=0, n-1
       x = x_min + i * dx
       s = s + 0.5d0 * (f(x) + f(x+dx))
    enddo
    integrate = s * dx
  end function integrate
end module integrate_mod

program main
  use user_func_mod
  use integrate_mod
  implicit none

  call user_func_initialize(1d0, 2d0)
  print *, integrate(user_func, 1.d0, 2.d0, 20000)
end program main


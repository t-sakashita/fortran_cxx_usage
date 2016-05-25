! trapezoidal.f90
module function_mod
contains
  real(8) function quadratic(x)
    implicit none
    real(8), intent(in) :: x
    quadratic = 3.d0 * x**2 + 1.d0
  end function quadratic
end module function_mod

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
    real(8) :: x, x2
    n = 20000
    h = (x_max - x_min) / n
    s = 0.d0
    do i=0, n-1
       x = x_min + i * h
       x2 = x_min + (i+1) * h
       s = s + 0.5d0 * (f(x) + f(x2))
       print *, "i=",i," partial_sum=", s * h
    enddo
    integrate = s * h
  end function integrate
  
end module integrate_mod

program main
  use function_mod
  use integrate_mod
  implicit none
  
  print *,integrate(quadratic, 0.d0, 1.d0)
end program main


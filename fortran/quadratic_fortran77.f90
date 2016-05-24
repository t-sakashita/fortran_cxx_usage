! quadratic_fortran77.f90
real(8) function quadratic(x)
  implicit none
  real(8), intent(in) :: x
  quadratic = 3.d0 * x**2 + 1.d0
end function quadratic

program main
  implicit none
  real(8) :: quadratic
  
  write(*,*) "val=", quadratic(2.d0)
end program main


! module_procedure.f90
module quadratic_mod
  interface quadratic
     module procedure quadratic_single, quadratic_double
  end interface quadratic

contains  
  real(4) function quadratic_single(x) result(y)
    implicit none
    real(4), intent(in) :: x
    y = 3.e0 * x**2 + 1.e0
  end function quadratic_single

  real(8) function quadratic_double(x) result(y)
    implicit none
    real(8), intent(in) :: x
    y = 3.d0 * x**2 + 1.d0
  end function quadratic_double

end module quadratic_mod

program main
  use quadratic_mod
  print *, quadratic(1.1e0)
  print *, quadratic(1.1d0)
  print *, quadratic_single(1.1e0)
  print *, quadratic_double(1.1d0)
end program main

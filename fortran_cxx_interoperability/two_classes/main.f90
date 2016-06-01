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


program main
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

  call construct(this2, 3)
  call integrate_trapezoid(this2, xmin, xmax, n, s)
  write(*,*) 'Result: ', s
  call destruct(this2)
  
end program main

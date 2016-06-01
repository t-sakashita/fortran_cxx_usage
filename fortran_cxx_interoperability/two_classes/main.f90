program main
  use integration_mod
  use user_functor1_mod
  use user_functor2_mod
  use fortran_functor_mod
  implicit none

  type(user_functor1_type) :: this, that
  type(user_functor2_type) :: this2
  type(fortran_functor_type) :: this3

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

  call construct(this3, 1.d0, 2.d0)
  call integrate_trapezoid(this3, xmin, xmax, n, s)
  write(*,*) 'Result: ', s
  call destruct(this3)
  
end program main

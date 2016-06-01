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

module fortran_functor_mod
  use base_functor_mod
  implicit none

  type, extends(base_functor_type) :: fortran_functor_type
     real(8) :: a, b
   contains
     procedure, pass(this) :: eval => f
  end type fortran_functor_type

  interface construct
    module procedure fortran_functor_construct
 end interface construct
 
  interface destruct
    module procedure fortran_functor_destruct
 end interface destruct
 
contains
  real(8) function f(this, x)
    class(fortran_functor_type), intent(in) :: this
    real(8), value, intent(in) :: x
    print *, "This is f"
    f = exp(-this%a*x) * cos(this%b*x)
  end function f

  subroutine fortran_functor_construct(this, a_in, b_in)
    type(fortran_functor_type), intent(inout) :: this
    real(8), intent(in) :: a_in, b_in
    this%a = a_in
    this%b = b_in
  end subroutine fortran_functor_construct
  
  subroutine fortran_functor_destruct(this)
    type(fortran_functor_type), intent(inout) :: this
  end subroutine fortran_functor_destruct
  
end module fortran_functor_mod


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

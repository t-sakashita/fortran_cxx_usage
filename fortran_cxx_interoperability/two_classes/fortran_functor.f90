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

module base_functor_mod
  use iso_c_binding
  implicit none
  public
  type, abstract :: base_functor_type
   contains
     procedure(base_functor_eval), deferred, pass(this) :: eval
  end type base_functor_type

  abstract interface
     real(8) function base_functor_eval(this, x)
       import :: base_functor_type
       class(base_functor_type), intent(in) :: this
       real(8), value, intent(in) :: x
     end function base_functor_eval
  end interface

end module base_functor_mod


module my_functor1_mod
  use base_functor_mod
  use iso_c_binding
  implicit none
  type, extends(base_functor_type) :: my_functor_type1
     type(c_ptr) :: ptr
   contains
     procedure, pass(this) :: eval => user_functor_eval
  end type my_functor_type1

  interface
     function user_functor_construct_c (a, b) result(ptr) bind(c,name="user_functor_construct")
      import
      real(8), value, intent(in) :: a, b
      type(c_ptr) :: ptr
    end function user_functor_construct_c
    subroutine user_functor_destruct_c (ptr) bind(c,name="user_functor_destruct")
      import
      type(c_ptr), value :: ptr
    end subroutine user_functor_destruct_c    
    function user_functor_eval_c (ptr, x) result(y) bind(c,name="user_functor_eval")
      use iso_c_binding
      import
      type(c_ptr), intent(in) :: ptr
      real(8), value, intent(in) :: x
      real(8) :: y
    end function user_functor_eval_c
 end interface
 
contains

  subroutine user_functor_construct(this,a,b)
    type(my_functor_type1), intent(out) :: this
    real(8), intent(in) :: a, b
    this%ptr = user_functor_construct_c(a,b)
  end subroutine user_functor_construct
  
  subroutine user_functor_destruct(this)
    type(my_functor_type1), intent(inout) :: this
    call user_functor_destruct_c(this%ptr)
    this%ptr = c_null_ptr
  end subroutine user_functor_destruct
  
  function user_functor_eval(this,x) result(y)
    class(my_functor_type1), intent(in) :: this
    real(8), value, intent(in) :: x
    real(8) :: y
    print *,"x0=", x
    y = user_functor_eval_c(this%ptr, x)
  end function user_functor_eval
  
end module my_functor1_mod


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
    real(8) :: x
    real(8) :: deltax

    if (steps <= 0) then
       res = 0.0
       return
    endif

    deltax = (xmax - xmin) / steps
    res = (this%eval(xmin) + this%eval(xmax)) / 2

    do i = 2, steps
       x = xmin + (i-1) * deltax
       res = res + this%eval(x)
    enddo
    
    res = res * deltax
  end subroutine integrate_trapezoid
end module integration_mod


program test_integrate
  use integration_mod
  use my_functor1_mod
  implicit none

  type(my_functor_type1) :: this, that

  real(8) :: xmin, xmax, result
  integer :: steps

  xmin = 1.d0
  xmax = 10.d0
  steps = 10.d0

  call integrate_trapezoid(this, xmin, xmax, steps, result)
  write(*,*) 'Result: ', result

  call integrate_trapezoid(that, xmin, xmax, steps, result)
  write(*,*) 'Result: ', result
end program test_integrate


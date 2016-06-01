module base_functor_mod
  implicit none
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

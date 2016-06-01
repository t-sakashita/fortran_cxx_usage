cmake_minimum_required(VERSION 2.8)

project(fortran_cxx_usage NONE)

# C++, C, and Fortran compilers
enable_language(CXX C Fortran)

# Linker for Fortran Program
option(USE_CXX_LINKER "Use C++ linker for Fortran program" OFF)
message(STATUS "Use C++ linker for Fortran program: " ${USE_CXX_LINKER})
if(USE_CXX_LINKER)
  set(ROKKO_USE_CXX_LINKER 1)
endif(USE_CXX_LINKER)

set(TARGET_NAME functor)
add_executable(${TARGET_NAME} integration.f90 fortran_functor.f90 user_functor1_wrapper.cpp user_functor2_wrapper.cpp base_functor.f90 user_functor1_wrapper.f90 user_functor2_wrapper.f90 main.f90)

if(USE_CXX_LINKER)
  SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES LINKER_LANGUAGE CXX)
endif(USE_CXX_LINKER)


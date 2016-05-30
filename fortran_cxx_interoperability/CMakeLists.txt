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
add_executable(${TARGET_NAME} wrapper.cpp main.f90)
#set_target_properties(${target_name} PROPERTIES OUTPUT_NAME ${name})
if(USE_CXX_LINKER)
  SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES LINKER_LANGUAGE CXX)
endif(USE_CXX_LINKER)


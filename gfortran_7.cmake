# Options for a Fortran 2003 program, GNU Fortran compiler version 7

# Fortran language options:
set(CMAKE_Fortran_FLAGS_INIT "-std=f2003")

# Error and warning options which have no effect at run-time:
string(APPEND CMAKE_Fortran_FLAGS_INIT
  " -fmax-errors=1 -pedantic -Wall -Wcharacter-truncation -Wunused-parameter"
  " -Wno-conversion -Wimplicit-interface -Wimplicit-procedure"
  " -Wno-integer-division -Wno-maybe-uninitialized")
## -Wrealloc-lhs-all

# Debugging options:
set(CMAKE_Fortran_FLAGS_DEBUG_INIT
  "-fbacktrace -ffpe-trap=invalid,zero,overflow")

# Code generation options:
string(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT
  " -fcheck=bounds,do,mem,pointer,recursion -finit-derived -finit-real=snan "
  "-O0")

set(CMAKE_Fortran_FLAGS_PROFILE_INIT "-p -g -O2")
set(CMAKE_EXE_LINKER_FLAGS_PROFILE_INIT "-p -g -O2")

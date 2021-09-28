set(CMAKE_Fortran_FLAGS_INIT "-f2003")

set(CMAKE_Fortran_FLAGS_DEBUG_INIT "-C=all -g90 -gline -nan -strict95")
#  -C=undefined is not binary compatible with Fortran code compiled
#  without that option, and is not compatible with calling C code
#  via a BIND(C) interface.

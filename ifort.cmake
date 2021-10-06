# Language:

set(CMAKE_Fortran_FLAGS_INIT
  " -noaltparam -stand f03 -standard-semantics -assume nostd_mod_proc_name")
# -standard-semantics by itself implies -assume std_mod_proc_name, and
# then compiling with the NetCDF Fortran library or the FortranGIS
# library might not work.

set(CMAKE_Fortran_FLAGS_DEBUG_INIT
  " -check bounds,format,output_conversion,pointers,stack,uninit")
# "-check all" includes "arg_temp_created", which is annoying so we
# detail "check bounds", etc.

# Data:

string(APPEND CMAKE_Fortran_FLAGS_INIT " -auto -mcmodel=medium")
string(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT " -init=arrays,minus_huge,snan")


# Compiler diagnostics:
string(APPEND CMAKE_Fortran_FLAGS_INIT
  " -warn declarations,general,stderrors,truncated_source,uncalled,unused,usage"
  " -traceback -diag-error-limit 1")
# -traceback has no impact on run-time execution speeds.

# Optimization:
string(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT " -O0")

# Floating point:
string(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT " -fp-stack-check -fpe-all=0")

# Debug:
string(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT
  " -debug full -debug-parameters all -ftrapuv")

set(CMAKE_Fortran_FLAGS_PROFILE_INIT "-p -g -O2")
set(CMAKE_EXE_LINKER_FLAGS_PROFILE_INIT "-p -g -O2")

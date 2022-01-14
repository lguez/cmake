list(APPEND CMAKE_MESSAGE_CONTEXT FindNetCDF_Fortran)

if(NOT TARGET NetCDF_Fortran::netcdff)
  find_package(PkgConfig REQUIRED)
  message(DEBUG "PKG_CONFIG_EXECUTABLE: ${PKG_CONFIG_EXECUTABLE}")
  pkg_check_modules(netcdff REQUIRED IMPORTED_TARGET GLOBAL
    netcdf-fortran)
  message(DEBUG "netcdff_INCLUDE_DIRS: ${netcdff_INCLUDE_DIRS}")
  message(VERBOSE "NetCDF-Fortran libraries: ${netcdff_LINK_LIBRARIES}")
  pkg_get_variable(nf_pcfiledir netcdf-fortran pcfiledir)
  message(DEBUG "Location of .pc file: ${nf_pcfiledir}")
  message(VERBOSE "netcdff_INCLUDEDIR: ${netcdff_INCLUDEDIR}")
  target_include_directories(PkgConfig::netcdff INTERFACE ${netcdff_INCLUDEDIR})
  add_library(NetCDF_Fortran::netcdff ALIAS PkgConfig::netcdff)
endif()

set(NetCDF_Fortran_FOUND True)
list(POP_BACK CMAKE_MESSAGE_CONTEXT)

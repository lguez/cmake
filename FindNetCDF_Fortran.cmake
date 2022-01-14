list(APPEND CMAKE_MESSAGE_CONTEXT FindNetCDF_Fortran)

if(TARGET NetCDF_Fortran::netcdff)
  set(NetCDF_Fortran_FOUND True)
else()
  find_package(PkgConfig REQUIRED)
  message(DEBUG "PKG_CONFIG_EXECUTABLE: ${PKG_CONFIG_EXECUTABLE}")
  pkg_check_modules(netcdff REQUIRED IMPORTED_TARGET GLOBAL
    netcdf-fortran)
  message(DEBUG "netcdff_INCLUDE_DIRS: ${netcdff_INCLUDE_DIRS}")
  message(VERBOSE "NetCDF-Fortran libraries: ${netcdff_LINK_LIBRARIES}")
  pkg_get_variable(nf_pcfiledir netcdf-fortran pcfiledir)
  message(DEBUG "Location of .pc file: ${nf_pcfiledir}")
  get_target_property(nf_INTERFACE_INC PkgConfig::netcdff
    INTERFACE_INCLUDE_DIRECTORIES)

  if(nf_INTERFACE_INC)
    message(VERBOSE
      "PkgConfig::netcdff.INTERFACE_INCLUDE_DIRECTORIES = "
      "${nf_INTERFACE_INC}")
  else()
    pkg_get_variable(pkg_nf_includedir netcdf-fortran includedir)
    message(VERBOSE "pkg_nf_includedir: ${pkg_nf_includedir}")
    target_include_directories(PkgConfig::netcdff INTERFACE
      ${pkg_nf_includedir})
  endif()

  add_library(NetCDF_Fortran::netcdff ALIAS PkgConfig::netcdff)
  set(NetCDF_Fortran_FOUND True)
endif()

list(POP_BACK CMAKE_MESSAGE_CONTEXT)

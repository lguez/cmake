list(APPEND CMAKE_MESSAGE_CONTEXT FindNetCDF_Fortran)

if(TARGET NetCDF_Fortran::netcdff)
  set(NetCDF_Fortran_FOUND True)
else()
  # Find NetCDF dependency:

  option(FIND_PACKAGE_PREFER_MODULE_netCDF
    "Use directly the find module for NetCDF")

  if(${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
    set(maybe_quiet QUIET)
  endif()
  
  if(${CMAKE_FIND_PACKAGE_NAME}_FIND_REQUIRED)
    set(maybe_required REQUIRED)
  endif()
  
  if(FIND_PACKAGE_PREFER_MODULE_netCDF)
    find_package(netCDF ${maybe_quiet} ${maybe_required})
  else()
    find_package(netCDF CONFIG ${maybe_quiet})

    if(NOT netCDF_FOUND)
      message(STATUS "Trying with netCDF module...")
      find_package(netCDF ${maybe_quiet} ${maybe_required})
    endif()
  endif()

  #-

  if(netCDF_FOUND)
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

    target_link_libraries(PkgConfig::netcdff INTERFACE netCDF::netcdf)
    add_library(NetCDF_Fortran::netcdff ALIAS PkgConfig::netcdff)
    set(NetCDF_Fortran_FOUND True)
  else()
    set(NetCDF_Fortran_FOUND False)
  endif()
endif()

list(POP_BACK CMAKE_MESSAGE_CONTEXT)

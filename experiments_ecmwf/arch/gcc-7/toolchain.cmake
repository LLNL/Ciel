# (C) Copyright 1988- ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation
# nor does it submit to any jurisdiction.

####################################################################
# COMPILER
####################################################################

set( ECBUILD_FIND_MPI ON )

# Disable OpenACC for GNU CPU builds
set( ENABLE_ACC OFF )

####################################################################
# Compiler FLAGS
####################################################################

# General Flags (add to default)
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -ffpe-trap=invalid,zero,overflow")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -fstack-arrays")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -fconvert=big-endian")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -fbacktrace")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -fno-second-underscore")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -ffree-form")
#set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -ffast-math")
#set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -fno-unsafe-math-optimizations")

if(DEFINED ENV{FASTMATH})
    if($ENV{FASTMATH} STREQUAL "1")
        message(STATUS "fast math enabled")
        set(ECBUILD_C_FLAGS "${ECBUILD_C_FLAGS} -ffast-math")
    endif()
else()
    message(STATUS "fast math disabled")
endif()

if(DEFINED ENV{OPT_LEVEL})
    if($ENV{OPT_LEVEL} STREQUAL "0")
        message(STATUS "O3 optimization disabled")
        set(ECBUILD_C_FLAGS "${ECBUILD_C_FLAGS} -O0")
    elseif($ENV{OPT_LEVEL} STREQUAL "3")
        message(STATUS "O3 optimization enabled")
        set(ECBUILD_C_FLAGS "${ECBUILD_C_FLAGS} -O3")
    endif()
else()
    message(STATUS "O3 optimization disabled")
    set(ECBUILD_C_FLAGS "${ECBUILD_C_FLAGS} -O0")
endif()

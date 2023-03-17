##===------------------------------------------------------------------------------*- CMake -*-===##
##
##                                   S E R I A L B O X
##
## This file is distributed under terms of BSD license. 
## See LICENSE.txt for more information.
##
##===------------------------------------------------------------------------------------------===##

cmake_minimum_required( VERSION 3.12 )

project( bundle VERSION 1.0.0 LANGUAGES C )

message( STATUS "--------------------------------------" )
message( STATUS "[serialbox]" )
add_subdirectory( serialbox )
message( STATUS "--------------------------------------" )
message( STATUS "[downstream_c]" )
add_subdirectory( downstream_c )
message( STATUS "--------------------------------------" )
message( STATUS "[downstream_fortran]" )
add_subdirectory( downstream_fortran )


##===------------------------------------------------------------------------------*- CMake -*-===##
##
##                                   S E R I A L B O X
##
## This file is distributed under terms of BSD license. 
## See LICENSE.txt for more information.
##
##===------------------------------------------------------------------------------------------===##

cmake_minimum_required(VERSION 3.12)

project( downstream_c VERSION 0.1.0 LANGUAGES C )

# RPATH handling
set( CMAKE_SKIP_BUILD_RPATH FALSE )
set( CMAKE_BUILD_WITH_INSTALL_RPATH FALSE )
set( CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib" )
set( CMAKE_MACOSX_RPATH "${CMAKE_INSTALL_RPATH}" )
set( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE )

# Output destination
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )

# Find dependencies
find_package( Serialbox REQUIRED )

# Build
add_executable( downstream_c example-01-laplacian.c )
target_link_libraries( downstream_c Serialbox::Serialbox_C )

# Install
install( TARGETS downstream_c DESTINATION bin )

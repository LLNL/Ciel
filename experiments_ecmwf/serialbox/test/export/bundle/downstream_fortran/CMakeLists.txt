##===------------------------------------------------------------------------------*- CMake -*-===##
##
##                                   S E R I A L B O X
##
## This file is distributed under terms of BSD license. 
## See LICENSE.txt for more information.
##
##===------------------------------------------------------------------------------------------===##

cmake_minimum_required(VERSION 3.12)

project( downstream_fortran VERSION 0.1.0 LANGUAGES Fortran C )

# Fortran module dir
set( CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/module )

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
add_library( downstream_fortran_ser m_ser.F90)
target_link_libraries( downstream_fortran_ser PUBLIC Serialbox::Serialbox_Fortran )
target_include_directories( downstream_fortran_ser INTERFACE $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}> )

add_executable( downstream_fortran_producer main_producer.F90 )
target_link_libraries( downstream_fortran_producer downstream_fortran_ser )

add_executable(downstream_fortran_consumer main_consumer.F90 )
target_link_libraries(downstream_fortran_consumer downstream_fortran_ser )

# Install
install( TARGETS downstream_fortran_producer downstream_fortran_consumer DESTINATION bin )
install( TARGETS downstream_fortran_ser DESTINATION lib )

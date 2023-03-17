##===------------------------------------------------------------------------------*- CMake -*-===##
##
##                                   S E R I A L B O X
##
## This file is distributed under terms of BSD license. 
## See LICENSE.txt for more information.
##
##===------------------------------------------------------------------------------------------===##

include(ProcessorCount)
ProcessorCount(MAKE_PARALLEL)

configure_file( test-bundle.sh.in ${CMAKE_CURRENT_BINARY_DIR}/test-bundle.sh @ONLY )
configure_file( test-individual.sh.in ${CMAKE_CURRENT_BINARY_DIR}/test-individual.sh @ONLY )

if( SERIALBOX_TESTING_EXPORT )

  unset( _test_args )
  if( CMAKE_TOOLCHAIN_FILE )
    list( APPEND _test_args "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}" )
  endif()
  
  if( SERIALBOX_ENABLE_FORTRAN AND SERIALBOX_ENABLE_C )
    add_test( NAME serialbox_test_export_bundle 
              COMMAND ${CMAKE_CURRENT_BINARY_DIR}/test-bundle.sh ${_test_args} )
    
    add_test( NAME serialbox_test_export_individual
              COMMAND ${CMAKE_CURRENT_BINARY_DIR}/test-individual.sh ${_test_args} )
  endif()

endif()

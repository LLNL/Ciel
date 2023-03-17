##===------------------------------------------------------------------------------*- CMake -*-===##
##
##                                   S E R I A L B O X
##
## This file is distributed under terms of BSD license. 
## See LICENSE.txt for more information.
##
##===------------------------------------------------------------------------------------------===##

cmake_minimum_required(VERSION 3.12)

if(SERIALBOX_ENABLE_FORTRAN)

  if( NOT DEFINED CMAKE_Fortran_MODULE_DIRECTORY )
    set( CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/module )
  endif()

  set(SOURCES_FORTRAN_SERIALIZE m_serialize.f90 m_ser_perturb.f90)
  add_library(SerialboxFortranSerializeObjects OBJECT ${SOURCES_FORTRAN_SERIALIZE})
  
  set(SOURCES_FORTRAN utils_ppser.f90 )
  if (SERIALBOX_ENABLE_FTG)
    set(SOURCES_FORTRAN ${SOURCES_FORTRAN} m_ser_ftg.f90 m_ser_ftg_cmp.f90)
  endif()

  add_library(SerialboxFortranObjects OBJECT ${SOURCES_FORTRAN})
  target_link_libraries(SerialboxFortranObjects PUBLIC SerialboxFortranSerializeObjects)

  add_library(SerialboxFortranStatic STATIC $<TARGET_OBJECTS:SerialboxFortranSerializeObjects> $<TARGET_OBJECTS:SerialboxFortranObjects>)
  target_link_libraries(SerialboxFortranStatic PRIVATE SerialboxFortranObjects)
  target_link_libraries(SerialboxFortranStatic PRIVATE SerialboxFortranSerializeObjects)
  target_link_libraries(SerialboxFortranStatic PRIVATE SerialboxCStatic)
  set_target_properties(SerialboxFortranStatic PROPERTIES VERSION ${Serialbox_VERSION_STRING})
  set_target_properties(SerialboxFortranStatic PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
  target_include_directories(SerialboxFortranStatic
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}> # for .mod files
        $<INSTALL_INTERFACE:include>
    )


  if(BUILD_SHARED_LIBS)
    set_target_properties( SerialboxFortranSerializeObjects PROPERTIES POSITION_INDEPENDENT_CODE ON )
    set_target_properties( SerialboxFortranObjects PROPERTIES POSITION_INDEPENDENT_CODE ON )
    add_library(SerialboxFortranShared SHARED $<TARGET_OBJECTS:SerialboxFortranSerializeObjects> $<TARGET_OBJECTS:SerialboxFortranObjects>)
    target_link_libraries(SerialboxFortranShared PRIVATE SerialboxFortranObjects)
    target_link_libraries(SerialboxFortranShared PRIVATE SerialboxFortranSerializeObjects)
    target_link_libraries(SerialboxFortranShared PRIVATE SerialboxCShared)
    set_target_properties(SerialboxFortranShared PROPERTIES VERSION ${Serialbox_VERSION_STRING})
    set_target_properties(SerialboxFortranShared PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
    target_include_directories(SerialboxFortranShared
      INTERFACE
          $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}> # for .mod files
          $<INSTALL_INTERFACE:include>
      )
  endif()

  serialbox_install_targets( TARGETS 
    SerialboxFortranStatic
    SerialboxFortranShared
    SerialboxFortranObjects
    SerialboxFortranSerializeObjects
  )

  # Install mod files
  install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include)
endif()

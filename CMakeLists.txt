####### CMakeLists.txt for RubySpaceWire

cmake_minimum_required(VERSION 2.8)

### Initial definition of cmake variables
set(CMAKE_INSTALL_PREFIX $ENV{HOME} CACHE PATH "install prefix")
set(CMAKE_BUILD_TYPE Release CACHE STRING "build type")
set(CMAKE_CXX_FLAGS_DEBUG "-g -W -Wall" CACHE STRING "CXX_FLAGS for debug")
set(CMAKE_C_FLAGS_DEBUG "-g -W -Wall" CACHE STRING "C_FLAGS for debug")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -W -Wall" CACHE STRING "CXX_FLAGS for release")
set(CMAKE_C_FLAGS_RELEASE "-O3 -W -Wall" CACHE STRING "C_FLAGS for release")

### RPATH
set(CMAKE_MACOSX_RPATH 1)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

### Definition of project
project(RubyROOT)
message("-- Install destination prefix: ${CMAKE_INSTALL_PREFIX}")
set(CMAKE_MODULE_PATH ${RubyROOT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})
add_definitions("-std=c++11")

### Options
option(ENABLE_MINUIT2 "enable Munuit2" ON)

### External libraries
### ROOT ###
set(ROOTSYS $ENV{ROOTSYS})
list(APPEND CMAKE_PREFIX_PATH ${ROOTSYS})
find_package(ROOT REQUIRED)
if(ENABLE_MINUIT2)
  find_package(ROOT REQUIRED COMPONENTS Minuit2)
endif()
set(ROOT_INC_DIR ${ROOT_INCLUDE_DIRS})
set(ROOT_LIB_DIR ${ROOT_LIBRARY_DIR})
set(ROOT_LIB ${ROOT_LIBRARIES})
list(APPEND CMAKE_INSTALL_RPATH ${ROOT_LIB_DIR})
message("-- ROOTSYS = ${ROOTSYS}")
message("-- ROOT_INC_DIR = ${ROOT_INC_DIR}")
message("-- ROOT_LIB_DIR = ${ROOT_LIB_DIR}")
message("-- ROOT libraries = ${ROOT_LIB}")

### subdirecties
add_subdirectory(ruby)

### END

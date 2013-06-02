####### CMakeLists.txt for RubySpaceWire

cmake_minimum_required(VERSION 2.8)

### Initial definition of cmake variables
set(CMAKE_INSTALL_PREFIX $ENV{HOME} CACHE PATH "install prefix")
set(CMAKE_BUILD_TYPE Release CACHE STRING "build type")
set(CMAKE_CXX_FLAGS_DEBUG "-g -W -Wall" CACHE STRING "CXX_FLAGS for debug")
set(CMAKE_C_FLAGS_DEBUG "-g -W -Wall" CACHE STRING "C_FLAGS for debug")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -W -Wall" CACHE STRING "CXX_FLAGS for release")
set(CMAKE_C_FLAGS_RELEASE "-O3 -W -Wall" CACHE STRING "C_FLAGS for release")

### Definition of project
project(RubyROOT)
message("-- Install destination prefix: ${CMAKE_INSTALL_PREFIX}")
set(CMAKE_MODULE_PATH ${RubyROOT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

### External libraries
### ROOT ###
set(ROOTSYS $ENV{ROOTSYS})
find_path(ROOT_INC_DIR
  NAMES TH1.h TTree.h
  PATHS ${ROOTSYS}/include/root ${ROOTSYS}/include)
find_path(ROOT_LIB_DIR
  NAMES libHist.so libTree.so
  PATHS ${ROOTSYS}/lib/root ${ROOTSYS}/lib)
set(ROOT_LIB
  Core Cint RIO Net Hist Graf Graf3d Gpad Tree
  Rint Postscript Matrix Physics MathCore Thread)
message("-- ROOTSYS = ${ROOTSYS}")
message("-- ROOT_INC_DIR = ${ROOT_INC_DIR}")
message("-- ROOT_LIB_DIR = ${ROOT_LIB_DIR}")

### subdirecties
add_subdirectory(ruby)

### END

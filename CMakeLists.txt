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

### External libraries
### ROOT ###
set(ROOTSYS $ENV{ROOTSYS})
# set(ROOTDIR "/root")
set(ROOTDIR "")
set(ROOT_INC_DIR ${ROOTSYS}/include${ROOTDIR})
set(ROOT_LIB_DIR ${ROOTSYS}/lib${ROOTDIR})
set(ROOT_LIB
  Core Cint RIO Net Hist Graf Graf3d Gpad Tree
  Rint Postscript Matrix Physics MathCore Thread)
message("-- ROOTSYS = ${ROOTSYS}")

### subdirecties
add_subdirectory(ruby)

### END

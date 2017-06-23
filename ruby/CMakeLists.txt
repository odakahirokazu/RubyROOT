########################################################
if(ENABLE_MINUIT2)
  set(ADDITIONAL_SWIG_FLAGS "-DUSE_MINUIT2")
  add_definitions("-DUSE_MINUIT2")
endif()

set(TARGET_EXT_LIBRARY RubyROOT)
set(TARGET_EXT_LIBRARY_OUTPUT root)
set(SWIG_IF_FILE root.i)
set(RUBY_EXT_INCLUDE_DIRS ../include ${ROOT_INC_DIR})
set(RUBY_EXT_LIBRARY_DIRS ${ROOT_LIB_DIR})
set(RUBY_EXT_LIBRARIES ${ROOT_LIB})
set(SWIG_FLAGS -minherit ${ADDITIONAL_SWIG_FLAGS})
set(ADDITIONAL_INSTALL_TARGET RubyROOT.rb)

########################################################

include(CreateSwigRuby)

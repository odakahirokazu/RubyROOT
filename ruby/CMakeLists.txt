########################################################
set(TARGET_EXT_LIBRARY root)
set(SWIG_IF_FILE ${TARGET_EXT_LIBRARY}.i)
set(RUBY_EXT_INCLUDE_DIRS ../include ${ROOT_INC_DIR})
set(RUBY_EXT_LIBRARY_DIRS ${ROOT_LIB_DIR})
set(RUBY_EXT_LIBRARIES ${ROOT_LIB})
set(SWIG_FLAGS "-minherit")
set(ADDITIONAL_INSTALL_TARGET RubyROOT.rb)
########################################################

include(CreateSwigRuby)

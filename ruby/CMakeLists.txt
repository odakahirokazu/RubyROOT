########################################################
set(target_binding RubyROOT)
set(target_binding_output root)
set(swig_if_file root.i)
########################################################
set(cxx_definitions )
set(swig_flags -minherit)

if(ENABLE_MINUIT2)
  list(APPEND cxx_definitions USE_MINUIT2)
  list(APPEND swig_flags -DUSE_MINUIT2)
endif()
########################################################
include(ANLNextSwigRuby)

########################################################
anlnext_add_swig_ruby_binding(${target_binding}
  MODULE_NAME ${target_binding_output}
  INTERFACE_FILE ${swig_if_file}
  INCLUDE_DIRECTORIES ../include ${ROOT_INC_DIR}
  LIBRARIES ${ROOT_LIB}
  SWIG_FLAGS ${swig_flags}
  COMPILE_DEFINITIONS ${cxx_definitions}
  INSTALL_DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/ruby
)

########################################################
# install Ruby libraries written in Ruby
########################################################
install(DIRECTORY library/
  DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/ruby
  FILES_MATCHING PATTERN "*.rb")

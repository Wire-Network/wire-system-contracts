add_contract(sysio.wrap sysio.wrap ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.wrap.cpp)

target_include_directories(sysio.wrap
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(sysio.wrap
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.wrap.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.wrap.contracts.md @ONLY )

target_compile_options( sysio.wrap PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )

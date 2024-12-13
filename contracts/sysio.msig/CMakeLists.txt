add_contract(sysio.msig sysio.msig ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.msig.cpp)

target_include_directories(sysio.msig
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(sysio.msig
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.msig.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.msig.contracts.md @ONLY )

target_compile_options( sysio.msig PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )

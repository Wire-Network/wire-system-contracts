add_contract(sysio.token sysio.token ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.token.cpp)

target_include_directories(sysio.token
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(sysio.token
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.token.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.token.contracts.md @ONLY )

target_compile_options( sysio.token PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )

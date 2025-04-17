add_contract(sysio.roa sysio.roa ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.roa.cpp)

target_include_directories(sysio.roa
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(sysio.roa
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.roa.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.roa.contracts.md @ONLY )

target_compile_options( sysio.roa PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )

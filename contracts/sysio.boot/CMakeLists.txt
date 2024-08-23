add_contract(sysio.boot sysio.boot ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.boot.cpp)

target_include_directories(sysio.boot
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(sysio.boot
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.boot.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.boot.contracts.md @ONLY )

target_compile_options( sysio.boot PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )

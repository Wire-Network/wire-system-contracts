add_contract(sysio.bios sysio.bios ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.bios.cpp)

target_include_directories(sysio.bios
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(sysio.bios
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.bios.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.bios.contracts.md @ONLY )

target_compile_options( sysio.bios PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )

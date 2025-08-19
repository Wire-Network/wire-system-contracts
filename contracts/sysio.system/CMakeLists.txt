add_contract(
  sysio.system
  sysio.system
  ${CMAKE_CURRENT_SOURCE_DIR}/src/sysio.system.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/delegate_bandwidth.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/exchange_state.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/native.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/producer_pay.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/voting.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/limit_auth_changes.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/block_info.cpp)

if(SYSTEM_CONFIGURABLE_WASM_LIMITS)
  target_compile_definitions(sysio.system PUBLIC SYSTEM_CONFIGURABLE_WASM_LIMITS)
endif()

if(SYSTEM_BLOCKCHAIN_PARAMETERS)
  target_compile_definitions(sysio.system PUBLIC SYSTEM_BLOCKCHAIN_PARAMETERS)
endif()

target_include_directories(sysio.system PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
                                               ${CMAKE_CURRENT_SOURCE_DIR}/../sysio.token/include)

set_target_properties(sysio.system PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/ricardian/sysio.system.contracts.md.in
               ${CMAKE_CURRENT_BINARY_DIR}/ricardian/sysio.system.contracts.md @ONLY)

target_compile_options(sysio.system PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian
                                           -R${CMAKE_CURRENT_BINARY_DIR}/ricardian)

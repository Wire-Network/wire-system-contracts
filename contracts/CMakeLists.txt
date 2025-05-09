cmake_minimum_required(VERSION 3.5)

project(contracts)

option(SYSTEM_CONFIGURABLE_WASM_LIMITS
       "Enables use of the host functions activated by the CONFIGURABLE_WASM_LIMITS protocol feature" ON)

option(SYSTEM_BLOCKCHAIN_PARAMETERS
       "Enables use of the host functions activated by the BLOCKCHAIN_PARAMETERS protocol feature" ON)

find_package(cdt REQUIRED)

set(CDT_VERSION_MIN "3.0")
set(CDT_VERSION_SOFT_MAX "3.0")
# set(CDT_VERSION_HARD_MAX "")

# Check the version of CDT
if(SYSTEM_ENABLE_CDT_VERSION_CHECK)
  set(VERSION_MATCH_ERROR_MSG "")
  CDT_CHECK_VERSION(VERSION_OUTPUT "${CDT_VERSION}" "${CDT_VERSION_MIN}" "${CDT_VERSION_SOFT_MAX}"
                      "${CDT_VERSION_HARD_MAX}" VERSION_MATCH_ERROR_MSG)
  if(VERSION_OUTPUT STREQUAL "MATCH")
    message(STATUS "Using CDT version ${CDT_VERSION}")
  elseif(VERSION_OUTPUT STREQUAL "WARN")
    message(
      WARNING
        "Using CDT version ${CDT_VERSION} even though it exceeds the maximum supported version of ${CDT_VERSION_SOFT_MAX}; continuing with configuration, however build may fail.\nIt is recommended to use CDT version ${CDT_VERSION_SOFT_MAX}.x"
    )
  else() # INVALID OR MISMATCH
    message(
      FATAL_ERROR
        "Found CDT version ${CDT_VERSION} but it does not satisfy version requirements: ${VERSION_MATCH_ERROR_MSG}\nPlease use CDT version ${CDT_VERSION_SOFT_MAX}.x"
    )
  endif()
endif()

set(ICON_BASE_URL "https://bucket.gitgo.app/frontend-assets/icons/")

set(ACCOUNT_ICON_URI "account-gradient.png")
set(ADMIN_ICON_URI "admin-gradient.png")
set(MULTISIG_ICON_URI "multisig-gradient.png")
set(RESOURCE_ICON_URI "resource-gradient.png")
set(REX_ICON_URI "wire-brandmark-transparent.png")
set(TOKEN_ICON_URI "token-gradient.png")
set(TRANSFER_ICON_URI "transfer-gradient.png")
set(VOTING_ICON_URI "voting-gradient.png")
add_subdirectory(sysio.bios)
add_subdirectory(sysio.boot)
add_subdirectory(sysio.msig)
add_subdirectory(sysio.system)
add_subdirectory(sysio.token)
add_subdirectory(sysio.wrap)
add_subdirectory(sysio.roa)

add_subdirectory(test_contracts)

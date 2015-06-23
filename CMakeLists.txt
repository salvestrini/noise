cmake_minimum_required(VERSION 3.1.0)

set(CMAKE_MODULE_PATH      "${CMAKE_SOURCE_DIR}/cmake")
#set(CMAKE_VERBOSE_MAKEFILE ON)

project(Noise)

include(GitVersionGen)
GIT_VERSION_GEN()

set(PACKAGE_URL  "https://github.com/salvestrini/noise"
  CACHE STRING "Package URL")
set(PACKAGE_BUGREPORT "salvestrini@gmail.com"
  CACHE STRING "Packaged bug-report email")
set(PACKAGE_VERSION "${PACKAGE_VERSION_MAJOR}.${PACKAGE_VERSION_MINOR}.${PACKAGE_VERSION_MICRO}"
  CACHE STRING "Package version")

message(STATUS "Package version is:         ${PACKAGE_VERSION}")
message(STATUS "Package URL is:             ${PACKAGE_URL}")
message(STATUS "Package bug-report address: ${PACKAGE_BUGREPORT}")
message(STATUS "Package install prefix:     ${CMAKE_INSTALL_PREFIX}")

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/noise/version.hh.in"
  "${CMAKE_CURRENT_BINARY_DIR}/noise/version.hh")

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "The NOISE library")
set(CPACK_PACKAGE_VENDOR              "Francesco Salvestrini")
set(CPACK_PACKAGE_DESCRIPTION_FILE    "${CMAKE_CURRENT_SOURCE_DIR}/README")
set(CPACK_RESOURCE_FILE_LICENSE       "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION_MAJOR       ${PACKAGE_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR       ${PACKAGE_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH       ${PACKAGE_VERSION_MICRO})
set(CPACK_PACKAGE_INSTALL_DIRECTORY   "CMake ${CMake_VERSION_MAJOR}.${CMake_VERSION_MINOR}")
include(CPack)

#include(CMakePrintSystemInformation)

include(FeatureSummary)
print_enabled_features()

add_subdirectory(noise)
add_subdirectory(pkg-config)
add_subdirectory(tests)

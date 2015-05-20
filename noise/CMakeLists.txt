enable_language(CXX)

include(CheckIncludeFile)
include(CheckSymbolExists)
include(GNUInstallDirs)

CHECK_INCLUDE_FILE(execinfo.h HAVE_EXECINFO_H)
if(HAVE_EXECINFO_H)
  CHECK_SYMBOL_EXISTS(backtrace         execinfo.h HAVE_BACKTRACE)
  CHECK_SYMBOL_EXISTS(backtrace_symbols execinfo.h HAVE_BACKTRACE_SYMBOLS)
endif()

CHECK_INCLUDE_FILE(regex.h HAVE_REGEX_H)
if(HAVE_REGEX_H)
  CHECK_SYMBOL_EXISTS(regexec  regex.h HAVE_REGEXEC)
  CHECK_SYMBOL_EXISTS(regcomp  regex.h HAVE_REGCOMP)
  CHECK_SYMBOL_EXISTS(regerror regex.h HAVE_REGERROR)
  CHECK_SYMBOL_EXISTS(regfree  regex.h HAVE_REGFREE)
endif()

set(NOISE_LIBRARIES "")

find_package(OpenAL REQUIRED)
if(OPENAL_FOUND)
  set(HAVE_OPENAL ON)
  set(NOISE_LIBRARIES ${NOISE_LIBRARIES} ${OPENAL_LIBRARY})
endif()

set(NOISE_INCLUDES "" PARENT_SCOPE)

set(SDL2_BUILDING_LIBRARY TRUE)
find_package(SDL2 REQUIRED)
if(SDL2_FOUND)
  set(HAVE_SDL2 ON)
  set(NOISE_LIBRARIES ${NOISE_LIBRARIES} ${SDL2_LIBRARY})

  set(NOISE_INCLUDES ${NOISE_INCLUDES} ${SDL2_INCLUDE_DIR} PARENT_SCOPE)
  include_directories(${SDL2_INCLUDE_DIR})

  message(STATUS "Found SDL2: " ${SDL2_LIBRARY})
else()
  message(STATUS "SDL2 NOT found!")
endif()

find_package(SDL2_mixer)
if(SDL2MIXER_FOUND)
  set(HAVE_SDL2_MIXER ON)
  set(NOISE_LIBRARIES ${NOISE_LIBRARIES} ${SDL2MIXER_LIBRARY})

  set(NOISE_INCLUDES ${NOISE_INCLUDES} ${SDL2MIXER_INCLUDE_DIR} PARENT_SCOPE)
  include_directories(${SDL2MIXER_INCLUDE_DIR})

  message(STATUS "Found SDL2_mixer: " ${SDL2MIXER_LIBRARY})
else()
  message(STATUS "SDL2_mixer NOT found!")
endif()

include_directories(${NOISE_INCLUDES})

option(WANT_DEBUG    "Debugging"     ON)
option(WANT_LOGS     "Logs"          ON)

set(NOISE_MIXER_FREQUENCY "44100" CACHE STRING "Frequency")
set(NOISE_MIXER_CHANNELS  "2"     CACHE STRING "Channels")

#configure_file("${CMAKE_CURRENT_SOURCE_DIR}/noise/version.hh.in" "${CMAKE_CURRENT_BINARY_DIR}/noise/version.hh")

configure_file(config.hh.in config.hh)

#if(CMAKE_COMPILER_IS_GNUCXX)
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")
#endif()

include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_BINARY_DIR})

add_library(noise SHARED
  noise.cc
)

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-Wall"   CXX_SUPPORTS_WALL)
CHECK_CXX_COMPILER_FLAG("-Werror" CXX_SUPPORTS_WERROR)
CHECK_CXX_COMPILER_FLAG("-Wundef" CXX_SUPPORTS_WUNDEF)

include(MacroAddCompileFlags)
if("${CXX_SUPPORTS_WALL}")
  MACRO_ADD_COMPILE_FLAGS(noise "-Wall")
endif()
if("${CXX_SUPPORTS_WERROR}")
  MACRO_ADD_COMPILE_FLAGS(noise "-Werror")
endif()
if("${CXX_SUPPORTS_WUNDEF}")
  MACRO_ADD_COMPILE_FLAGS(noise "-Wundef")
endif()

target_link_libraries(noise ${NOISE_LIBRARIES})

install(TARGETS noise DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})

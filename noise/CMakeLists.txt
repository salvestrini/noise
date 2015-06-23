enable_language(CXX)

include(CheckIncludeFile)
include(CheckSymbolExists)
include(GNUInstallDirs)

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

include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_BINARY_DIR})

add_library(noise SHARED
  noise.cc
)

set_property(TARGET noise PROPERTY CXX_STANDARD 11)


message(STATUS "Your CMake version supports these C++ features:")
get_property(known_features GLOBAL PROPERTY CMAKE_CXX_KNOWN_FEATURES)
foreach(i ${known_features})
  message(STATUS "  ${i}")
endforeach()

message(STATUS "Your C++ compiler supports these C++ features:")
foreach(i ${CMAKE_CXX_COMPILE_FEATURES})
  message(STATUS "  ${i}")
endforeach()

##target_compile_features(noise PRIVATE cxx_range_for)
if(CMAKE_COMPILER_IS_GNUCXX)
  include(CheckCXXCompilerFlag)
  include(MacroAddCompileFlags)

  CHECK_CXX_COMPILER_FLAG("-Wall"   CXX_SUPPORTS_WALL)
  if("${CXX_SUPPORTS_WALL}")
    MACRO_ADD_COMPILE_FLAGS(noise "-Wall")
  endif()
  CHECK_CXX_COMPILER_FLAG("-Werror" CXX_SUPPORTS_WERROR)
#  if("${CXX_SUPPORTS_WERROR}")
#    MACRO_ADD_COMPILE_FLAGS(noise "-Werror")
#  endif()
  CHECK_CXX_COMPILER_FLAG("-Wundef" CXX_SUPPORTS_WUNDEF)
  if("${CXX_SUPPORTS_WUNDEF}")
    MACRO_ADD_COMPILE_FLAGS(noise "-Wundef")
  endif()
#  CHECK_CXX_COMPILER_FLAG("-std=c++11" CXX_SUPPORTS_STDCXX11)
#  if("${CXX_SUPPORTS_STDCXX11}")
#    MACRO_ADD_COMPILE_FLAGS(noise "-std=c++11")
#  endif()
endif()


target_link_libraries(noise ${NOISE_LIBRARIES})

install(TARGETS noise DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})

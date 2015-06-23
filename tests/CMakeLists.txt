include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/noise)

include_directories(${CMAKE_BINARY_DIR})
include_directories(${CMAKE_BINARY_DIR}/noise)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_BINARY_DIR})

include_directories(${NOISE_INCLUDES})

link_directories(${CMAKE_BINARY_DIR}/noise)

add_executable(test-01 test-01.cc)

target_link_libraries(test-01 noise)

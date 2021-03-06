find_path(SDL2MIXER_INCLUDE_DIR SDL_mixer.h
  HINTS
  $ENV{SDL2MIXERDIR}
  $ENV{SDL2DIR}
  PATH_SUFFIXES include/SDL2 include
  PATHS
  /usr/local/include/SDL2
  /usr/include/SDL2
)
#message("SDL2MIXER_INCLUDE_DIR is ${SDL2MIXER_INCLUDE_DIR}")

find_library(SDL2MIXER_LIBRARY
  NAMES SDL2_mixer
  HINTS
  $ENV{SDL2MIXERDIR}
  $ENV{SDL2DIR}
  PATH_SUFFIXES lib64 lib
  PATHS
  /usr/local
  /usr
)
#message("SDL2MIXER_LIBRARY is ${SDL2MIXER_LIBRARY}")

set(SDL2MIXER_FOUND "NO")
if(SDL2MIXER_LIBRARY AND SDL2MIXER_INCLUDE_DIR)
  set(SDL2MIXER_FOUND "YES")
endif(SDL2MIXER_LIBRARY AND SDL2MIXER_INCLUDE_DIR)

include(GNUInstallDirs)
include(MacroSetOption)
noise_set_option(
  NOISE_BUILD_SHARED_LIBS
  TRUE BOOL
  "TRUE to build shared libraries")

if(NOISE_BUILD_SHARED_LIBS)
  noise_set_option(
    NOISE_INSTALL_PKGCONFIG_FILES TRUE BOOL
    "TRUE to automatically install pkg-config files")
  if(NOISE_INSTALL_PKGCONFIG_FILES)

      configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/noise.pc.in"
        "${CMAKE_CURRENT_BINARY_DIR}/noise.pc"
        @ONLY)
      install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/noise.pc"
        DESTINATION "${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}/pkgconfig")

#    foreach(noise_module IN ITEMS all core fs gfx io net sfx ui)
#      configure_file(
#        "${CMAKE_CURRENT_SOURCE_DIR}/noise-${noise_module}.pc.in"
#        "${CMAKE_CURRENT_BINARY_DIR}/noise-${noise_module}.pc"
#        @ONLY)
#      install(FILES
#        "${CMAKE_CURRENT_BINARY_DIR}/noise-${noise_module}.pc"
#        DESTINATION "${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}/pkgconfig")
#    endforeach()

  endif()
else()
  if(NOISE_INSTALL_PKGCONFIG_FILES)
    message(WARNING "No pkg-config files are provided for static linking (NOISE_INSTALL_PKGCONFIG_FILES will be ignored).")
  endif()
endif()

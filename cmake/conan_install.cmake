if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan_provider.cmake")
    message(STATUS "Downloading conan_provider.cmake")
    file(DOWNLOAD
        "https://github.com/conan-io/cmake-conan/raw/develop2/conan_provider.cmake"
        "${CMAKE_BINARY_DIR}/conan_provider.cmake"
    )
endif()

set(CMAKE_PROJECT_TOP_LEVEL_INCLUDES "${CMAKE_BINARY_DIR}/conan_provider.cmake")


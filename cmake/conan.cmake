if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(STATUS "Downloading conan.cmake")
    file(DOWNLOAD
        "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
        "${CMAKE_BINARY_DIR}/conan.cmake"
    )
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)

conan_cmake_run(
    REQUIRES
        boost_asio/1.69.0@bincrafters/stable
        boost_program_options/1.69.0@bincrafters/stable
        boost_system/1.69.0@bincrafters/stable
        boost_thread/1.69.0@bincrafters/stable
        boost_random/1.69.0@bincrafters/stable
        cmake_findboost_modular/1.69.0@bincrafters/stable
        msgpack/3.2.1
        websocketpp/0.8.2
        yaml-cpp/0.6.3
        zlib/1.2.11
        bzip2/1.0.8
    BASIC_SETUP
    CMAKE_TARGETS
    GENERATORS cmake_find_package
    BUILD missing
    PROFILE_AUTO ALL
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})

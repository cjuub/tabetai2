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
        range-v3/0.10.0
        yaml-cpp/0.6.3
        grpc/1.42.0
    BASIC_SETUP
    CMAKE_TARGETS
    GENERATORS cmake_find_package
    BUILD missing
    PROFILE_AUTO ALL
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})

find_package(range-v3 REQUIRED)
target_compile_options(range-v3::range-v3
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
            /Zc:preprocessor;
            /permissive-;
        >
)

find_package(yaml-cpp REQUIRED)
target_compile_definitions(yaml-cpp::yaml-cpp
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
            _SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING;
        >
)

find_package(gRPC REQUIRED)
add_library(grpc++ ALIAS gRPC::grpc++)
add_library(grpc++_reflection ALIAS gRPC::grpc++_reflection)
add_library(libprotobuf ALIAS protobuf::libprotobuf)
set(grpc_cpp_plugin $<TARGET_FILE:gRPC::grpc_cpp_plugin>)
set(protoc $<TARGET_FILE:protobuf::protoc>)

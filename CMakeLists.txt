cmake_minimum_required(VERSION 3.26)

option(TABETAI2_USE_CONAN "Use Conan instead of FetchContent to download 3rd-party dependencies" OFF)

# Must be before first project() due to CMAKE_PROJECT_TOP_LEVEL_INCLUDES being set
if(TABETAI2_USE_CONAN)
    include(cmake/conan_install.cmake)
endif()

project(tabetai2)


if(TABETAI2_USE_CONAN)
    include(cmake/conan.cmake)
else()
    add_subdirectory(third_party/range-v3)
    add_subdirectory(third_party/grpc)
    add_subdirectory(third_party/yaml_cpp)
endif()
add_subdirectory(third_party/catch2) # Header-only, no dependencies.

add_subdirectory(warning)

add_subdirectory(core/communicator)
add_subdirectory(core/data_publisher)
add_subdirectory(core/database)
add_subdirectory(core/ingredient)
add_subdirectory(core/recipe)
add_subdirectory(core/repository)
add_subdirectory(core/schedule)
add_subdirectory(core/server)
add_subdirectory(core/util)

add_subdirectory(grpc/proto)
add_subdirectory(grpc/grpc_communicator)

add_subdirectory(yaml_database)

add_subdirectory(application_server)
add_subdirectory(application)

add_subdirectory(gui)

enable_testing()

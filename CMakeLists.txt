cmake_minimum_required(VERSION 3.17)

project(tabetai2)

option(TABETAI2_USE_CONAN "Use Conan instead of FetchContent to download 3rd-party dependencies" ON)

add_subdirectory(application)
add_subdirectory(core/database)
add_subdirectory(core/ingredient)
add_subdirectory(core/data_publisher)
add_subdirectory(core/repository)
add_subdirectory(core/server)
add_subdirectory(core/util)
add_subdirectory(wamp_publisher)
add_subdirectory(warning)

if(TABETAI2_USE_CONAN)
    include(cmake/conan.cmake)
else()
    add_subdirectory(third_party/boost)
    add_subdirectory(third_party/websocketpp)
    add_subdirectory(third_party/msgpack_c)
endif()
add_subdirectory(third_party/autobahn_cpp) # Doesn't exist on conan.

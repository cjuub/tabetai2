cmake_minimum_required(VERSION 3.17)

project(tabetai2)

option(TABETAI2_USE_CONAN "Use Conan instead of FetchContent to download 3rd-party dependencies" ON)

if(TABETAI2_USE_CONAN)
    include(cmake/conan.cmake)
else()
    add_subdirectory(third_party/boost)
    add_subdirectory(third_party/websocketpp)
    add_subdirectory(third_party/msgpack_c)
    add_subdirectory(third_party/yaml_cpp)
endif()
add_subdirectory(third_party/autobahn_cpp) # Doesn't exist on conan.

add_subdirectory(application)
add_subdirectory(core/database)
add_subdirectory(core/ingredient)
add_subdirectory(core/recipe)
add_subdirectory(core/data_publisher)
add_subdirectory(core/repository)
add_subdirectory(core/server)
add_subdirectory(core/util)
add_subdirectory(wamp/wamp_publisher)
add_subdirectory(wamp/wamp_session)
add_subdirectory(warning)
add_subdirectory(yaml_database)

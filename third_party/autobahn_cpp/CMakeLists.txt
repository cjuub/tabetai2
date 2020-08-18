include(FetchContent)

FetchContent_GetProperties(Boost
    SOURCE_DIR Boost_SOURCE_DIR
)
set(BOOST_ROOT "${Boost_SOURCE_DIR}")

FetchContent_GetProperties(websocketpp
    SOURCE_DIR websocketpp_SOURCE_DIR
)
set(Websocketpp_INCLUDE_DIR "${websocketpp_SOURCE_DIR}/websocketpp")

FetchContent_GetProperties(msgpack-c
    SOURCE_DIR msgpack-c_SOURCE_DIR
)
set(MSGPACK_ROOT "${msgpack-c_SOURCE_DIR}")

FetchContent_Declare(
    autobahn_cpp
    GIT_REPOSITORY https://github.com/crossbario/autobahn-cpp.git
    GIT_TAG        531341709b274c0cb75aff4018b7980e8bb99bb5
)

FetchContent_MakeAvailable(autobahn_cpp)

target_link_libraries(autobahn_cpp
    INTERFACE
        $<$<BOOL:${WIN32}>:ws2_32>
)

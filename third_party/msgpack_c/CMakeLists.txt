include(FetchContent)

FetchContent_Declare(
    msgpack-c
    GIT_REPOSITORY https://github.com/msgpack/msgpack-c.git
    GIT_TAG        cpp-3.3.0
)

FetchContent_MakeAvailable(msgpack-c)

include(FetchContent)

FetchContent_Declare(Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG        fd9f5ac661f87335ecd70d39849c1d3a90f1c64d # v2.13.1
)

FetchContent_MakeAvailable(Catch2)

FetchContent_GetProperties(Catch2
    SOURCE_DIR Catch2_SOURCE_DIR
)

list(APPEND CMAKE_MODULE_PATH ${Catch2_SOURCE_DIR}/contrib)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} PARENT_SCOPE)

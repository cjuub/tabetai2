include(FetchContent)

FetchContent_Declare(
    boost-cmake
    GIT_REPOSITORY https://github.com/Orphis/boost-cmake.git
    GIT_TAG        70b12f62da331dd402b78102ec8f6a15d59a7af9
)

FetchContent_MakeAvailable(boost-cmake)

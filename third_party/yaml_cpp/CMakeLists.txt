include(FetchContent)

if(NOT TABETAI2_USE_CONAN)
    FetchContent_Declare(
        yaml_cpp
        GIT_REPOSITORY https://github.com/jbeder/yaml-cpp
        GIT_TAG        98acc5a8874faab28b82c28936f4b400b389f5d6
    )

    FetchContent_MakeAvailable(yaml_cpp)
endif()

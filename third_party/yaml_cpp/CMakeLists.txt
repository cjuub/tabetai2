include(FetchContent)

FetchContent_Declare(
    yaml_cpp
    GIT_REPOSITORY https://github.com/jbeder/yaml-cpp
    GIT_TAG        yaml-cpp-0.7.0
)

FetchContent_MakeAvailable(yaml_cpp)

# disable warnings for this target
get_target_property(yaml-cpp_include_dirs yaml-cpp INTERFACE_INCLUDE_DIRECTORIES)
set_target_properties(yaml-cpp PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${yaml-cpp_include_dirs}")

include(FetchContent)

FetchContent_Declare(
    yaml_cpp
    GIT_REPOSITORY https://github.com/jbeder/yaml-cpp
    # 0.8.0 does not compile, use latest hash at the
    GIT_TAG        2f86d13775d119edbb69af52e5f566fd65c6953b
)

FetchContent_MakeAvailable(yaml_cpp)

# disable warnings for this target
get_target_property(yaml-cpp_include_dirs yaml-cpp INTERFACE_INCLUDE_DIRECTORIES)
set_target_properties(yaml-cpp PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${yaml-cpp_include_dirs}")

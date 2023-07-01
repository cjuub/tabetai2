include(FetchContent)

FetchContent_Declare(
    range-v3
    GIT_REPOSITORY https://github.com/ericniebler/range-v3.git
    GIT_TAG        0.12.0
)

FetchContent_MakeAvailable(range-v3)

# disable warnings for this target
get_target_property(range-v3_include_dirs range-v3 INTERFACE_INCLUDE_DIRECTORIES)
set_target_properties(range-v3 PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${range-v3_include_dirs}")

add_library(warning INTERFACE)
target_compile_options(warning INTERFACE
    $<$<CXX_COMPILER_ID:Clang,GNU>:
        -Wall;
        -Wcast-align;
        -Wdouble-promotion;
        -Werror;
        -Wextra;
        -Wformat=2;
        -Wmissing-declarations;
        -Wnon-virtual-dtor;
        -Wnull-dereference;
        -Wold-style-cast;
        -Woverloaded-virtual;
        -Wshadow;
        -Wundef;
    >
    $<$<CXX_COMPILER_ID:MSVC>:
        /permissive-;
        /W4;
        /WX;
    >
)

add_library(warning_low INTERFACE)
target_compile_options(warning_low INTERFACE
    $<$<CXX_COMPILER_ID:Clang,GNU>:
        -Wall;
        -Wcast-align;
        -Werror;
        -Wextra;
        -Wformat=2;
        -Wmissing-declarations;
        -Wnull-dereference;
        -Wno-ignored-qualifiers; # autobahn-cpp
        -Wno-unused-parameter; # autobahn-cpp
    >
    $<$<CXX_COMPILER_ID:GNU>:
        -Wno-cast-function-type; # boost/asio
        -Wno-deprecated-copy; # autobahn-cpp
    >
    $<$<CXX_COMPILER_ID:MSVC>:
        /W3;
        /WX;
    >
)
target_compile_definitions(warning_low
    INTERFACE
        _SILENCE_CXX17_ALLOCATOR_VOID_DEPRECATION_WARNING # boost/asio
)
add_library(warning::low ALIAS warning_low)

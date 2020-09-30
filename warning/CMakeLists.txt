add_library(tabetai_warning INTERFACE)
add_library(tabetai::warning ALIAS tabetai_warning)
target_compile_options(tabetai_warning INTERFACE
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

add_library(tabetai_warning_low INTERFACE)
add_library(tabetai::warning::low ALIAS tabetai_warning_low)
target_compile_options(tabetai_warning_low INTERFACE
    $<$<CXX_COMPILER_ID:Clang,GNU>:
        -Wall;
        -Wcast-align;
        -Werror;
        -Wextra;
        -Wformat=2;
        -Wmissing-declarations;
        -Wnull-dereference;
    >
    $<$<CXX_COMPILER_ID:GNU>:
        -Wno-cast-function-type; # boost/asio
    >
    $<$<CXX_COMPILER_ID:MSVC>:
        /W3;
        /WX;
    >
)
target_compile_definitions(tabetai_warning_low
    INTERFACE
        _SILENCE_CXX17_ALLOCATOR_VOID_DEPRECATION_WARNING # boost/asio
)

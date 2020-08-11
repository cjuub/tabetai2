project(warning)

add_library(${PROJECT_NAME} INTERFACE)

target_compile_options(${PROJECT_NAME} INTERFACE
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

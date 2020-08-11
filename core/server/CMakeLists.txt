project(server)

add_library(${PROJECT_NAME}
    include/server/server.h
    include/server/server_factory.h
    src/server.cpp
)

set_target_properties(${PROJECT_NAME}
    PROPERTIES
        LINKER_LANGUAGE CXX
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        ingredient
        warning
)
project(server)

add_library(${PROJECT_NAME}
    include/server/server.h
    include/server/server_factory.h
    src/impl/server.h
    src/impl/server.cpp
    src/server_factory.cpp
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
    PRIVATE
        src
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        ingredient
        warning
)
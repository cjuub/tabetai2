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

set_target_properties(${PROJECT_NAME}
    PROPERTIES
        CXX_STANDARD 20
        CXX_STANDARD_REQUIRED YES
        CXX_EXTENSIONS NO
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
    PRIVATE
        src
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        data_publisher
    PRIVATE
        ingredient
        recipe
        warning
        yaml_database
)
project(tabetai_server)

add_library(${PROJECT_NAME}
    include/server/server.h
    include/server/server_factory.h
    src/impl/server.h
    src/impl/server.cpp
    src/server_factory.cpp
)
add_library(tabetai::server ALIAS ${PROJECT_NAME})

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
        tabetai::data_publisher
    PRIVATE
        tabetai::ingredient
        tabetai::recipe
        tabetai::warning
        tabetai::yaml_database
)
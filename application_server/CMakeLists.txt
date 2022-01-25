project(tabetai_application_server)

add_library(${PROJECT_NAME}
        include/application_server/server_factory.h
        src/server_factory.cpp
)
add_library(tabetai::application_server ALIAS ${PROJECT_NAME})

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
)

target_link_libraries(${PROJECT_NAME}
    INTERFACE
        tabetai::data_publisher
    PRIVATE
        tabetai::grpc_communicator
        tabetai::server
        tabetai::yaml_database
        tabetai::warning
)

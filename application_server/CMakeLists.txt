project(application_server)

add_library(${PROJECT_NAME}
        include/application_server/server_factory.h
        src/server_factory.cpp
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
    INTERFACE
        data_publisher
    PRIVATE
        grpc_communicator
        grpc_server
        server
        yaml_database
)

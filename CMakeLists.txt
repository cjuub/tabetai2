cmake_minimum_required(VERSION 3.31)

project(tabetai2)

add_subdirectory(third_party/grpc)
add_subdirectory(third_party/yaml_cpp)
add_subdirectory(third_party/catch2)

add_subdirectory(warning)

enable_testing()

add_subdirectory(core/communicator)
add_subdirectory(core/data_publisher)
add_subdirectory(core/database)
add_subdirectory(core/ingredient)
add_subdirectory(core/recipe)
add_subdirectory(core/repository)
add_subdirectory(core/schedule)
add_subdirectory(core/server)
add_subdirectory(core/util)

add_subdirectory(grpc/proto)
add_subdirectory(grpc/grpc_communicator)

add_subdirectory(yaml_database)

add_subdirectory(application_server)
add_subdirectory(application)

add_subdirectory(gui)

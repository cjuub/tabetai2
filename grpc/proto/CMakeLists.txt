project(tabetai2_grpc_proto)

set(gen_output ${CMAKE_BINARY_DIR}/gen/proto)
file(MAKE_DIRECTORY ${gen_output})

get_filename_component(tabetai2_proto "${CMAKE_SOURCE_DIR}/data/proto/tabetai2.proto" ABSOLUTE)
get_filename_component(tabetai2_proto_path "${tabetai2_proto}" PATH)
add_custom_command(
    OUTPUT
        ${gen_output}/tabetai2.pb.cc
        ${gen_output}/tabetai2.pb.h
        ${gen_output}/tabetai2.grpc.pb.cc
        ${gen_output}/tabetai2.grpc.pb.h
    COMMAND
        protoc
    ARGS
        --grpc_out "${gen_output}"
        --cpp_out "${gen_output}"
        -I "${tabetai2_proto_path}"
        --plugin=protoc-gen-grpc=$<TARGET_FILE:grpc_cpp_plugin> "${tabetai2_proto}"
    DEPENDS
        "${tabetai2_proto}"
)


add_library(${PROJECT_NAME}
    ${gen_output}/tabetai2.pb.cc
    ${gen_output}/tabetai2.pb.h
    ${gen_output}/tabetai2.grpc.pb.cc
    ${gen_output}/tabetai2.grpc.pb.h
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        ${gen_output}
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        grpc++_reflection
        libprotobuf
)

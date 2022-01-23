# Proto file
get_filename_component(tabetai2_proto "../protos/tabetai2.proto" ABSOLUTE)
get_filename_component(tabetai2_proto_path "${tabetai2_proto}" PATH)

# Generated sources
set(tabetai2_proto_srcs "${CMAKE_CURRENT_BINARY_DIR}/tabetai2.pb.cc")
set(tabetai2_proto_hdrs "${CMAKE_CURRENT_BINARY_DIR}/tabetai2.pb.h")
set(tabetai2_grpc_srcs "${CMAKE_CURRENT_BINARY_DIR}/tabetai2.grpc.pb.cc")
set(tabetai2_grpc_hdrs "${CMAKE_CURRENT_BINARY_DIR}/tabetai2.grpc.pb.h")
add_custom_command(
        OUTPUT "${tabetai2_proto_srcs}" "${tabetai2_proto_hdrs}" "${tabetai2_grpc_srcs}" "${tabetai2_grpc_hdrs}"
        COMMAND ${_PROTOBUF_PROTOC}
        ARGS --grpc_out "${CMAKE_CURRENT_BINARY_DIR}"
        --cpp_out "${CMAKE_CURRENT_BINARY_DIR}"
        -I "${tabetai2_proto_path}"
        --plugin=protoc-gen-grpc="${_GRPC_CPP_PLUGIN_EXECUTABLE}"
        "${tabetai2_proto}"
        DEPENDS "${tabetai2_proto}")

# Include generated *.pb.h files
include_directories("${CMAKE_CURRENT_BINARY_DIR}")

add_library(tabetai2_grpc_proto
        ${tabetai2_grpc_srcs}
        ${tabetai2_grpc_hdrs}
        ${tabetai2_proto_srcs}
        ${tabetai2_proto_hdrs})
target_link_libraries(tabetai2_grpc_proto
        ${_REFLECTION}
        ${_GRPC_GRPCPP}
        ${_PROTOBUF_LIBPROTOBUF})

target_include_directories(tabetai2_grpc_proto
    PUBLIC
        ${CMAKE_CURRENT_BINARY_DIR}
)
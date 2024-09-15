project(tabetai_gui_grpc_proto)

set(gen_output ${PROJECT_SOURCE_DIR}/tabetai2_flutter/lib/backend/gen/proto)
file(MAKE_DIRECTORY ${gen_output})

get_filename_component(tabetai2_proto "${CMAKE_SOURCE_DIR}/data/proto/tabetai2.proto" ABSOLUTE)
get_filename_component(tabetai2_proto_path "${tabetai2_proto}" PATH)

set(DART "$ENV{FLUTTER_DART_BIN}")
set(GRPC_DART_PLUGIN "$ENV{GRPC_DART_PLUGIN}")
add_custom_command(
    OUTPUT
        ${GRPC_DART_PLUGIN}
    COMMAND
        ${DART}
    ARGS
        pub global activate protoc_plugin
)

add_custom_target(install_grpc_dart_plugin
    DEPENDS
        ${GRPC_DART_PLUGIN}
)

add_custom_command(
    OUTPUT
        ${gen_output}/tabetai2.pb.dart
        ${gen_output}/tabetai2.pbgrpc.dart
    COMMAND
        ${PROTOC}
    ARGS
        --dart_out=grpc:"${gen_output}"
        -I "${tabetai2_proto_path}"
        --plugin protoc-gen-dart=${GRPC_DART_PLUGIN} "${tabetai2_proto}"
    DEPENDS
        install_grpc_dart_plugin
        "${tabetai2_proto}"
)

add_custom_target(${PROJECT_NAME}
    DEPENDS
        ${gen_output}/tabetai2.pb.dart
        ${gen_output}/tabetai2.pbgrpc.dart
)

add_dependencies(tabetai_grpc_proto ${PROJECT_NAME})

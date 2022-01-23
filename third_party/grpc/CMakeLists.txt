include(FetchContent)

FetchContent_Declare(
        grpc
        GIT_REPOSITORY https://github.com/grpc/grpc.git
        GIT_TAG        v1.42.0
)

FetchContent_MakeAvailable(grpc)

set(_PROTOBUF_LIBPROTOBUF libprotobuf PARENT_SCOPE)
set(_REFLECTION grpc++_reflection PARENT_SCOPE)
set(_PROTOBUF_PROTOC $<TARGET_FILE:protoc> PARENT_SCOPE)
set(_GRPC_GRPCPP grpc++ PARENT_SCOPE)
set(_GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:grpc_cpp_plugin> PARENT_SCOPE)

find_package(range-v3 REQUIRED)
target_compile_options(range-v3::range-v3
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
            /Zc:preprocessor;
            /permissive-;
        >
)

find_package(yaml-cpp REQUIRED)
target_compile_definitions(yaml-cpp
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
            _SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING;
        >
)

find_package(gRPC REQUIRED)
add_library(grpc::grpc++ ALIAS gRPC::grpc++)
add_library(grpc::grpc++_reflection ALIAS gRPC::grpc++_reflection)
set(GRPC_CPP_PLUGIN $<TARGET_FILE:gRPC::grpc_cpp_plugin>)
set(PROTOC $<TARGET_FILE:protobuf::protoc>)

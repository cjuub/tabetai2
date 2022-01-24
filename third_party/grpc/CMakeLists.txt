include(FetchContent)

FetchContent_Declare(
        grpc
        GIT_REPOSITORY https://github.com/grpc/grpc.git
        GIT_TAG        v1.42.0
)

FetchContent_MakeAvailable(grpc)

set(grpc_cpp_plugin $<TARGET_FILE:grpc_cpp_plugin> PARENT_SCOPE)
set(protoc $<TARGET_FILE:protoc> PARENT_SCOPE)

include(FetchContent)

FetchContent_Declare(
    grpc
    GIT_REPOSITORY https://github.com/grpc/grpc.git
    GIT_TAG        v1.50.1
)

FetchContent_MakeAvailable(grpc)

add_library(grpc::grpc++ ALIAS grpc++)
add_library(grpc::grpc++_reflection ALIAS grpc++_reflection)
set(GRPC_CPP_PLUGIN $<TARGET_FILE:grpc_cpp_plugin> PARENT_SCOPE)
set(PROTOC $<TARGET_FILE:protoc> PARENT_SCOPE)

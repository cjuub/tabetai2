project(grpc_communicator)

add_library(${PROJECT_NAME}
    include/grpc_communicator/grpc_communicator.h
    src/grpc_communicator.cpp
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

set_target_properties(${PROJECT_NAME}
    PROPERTIES
        CXX_STANDARD 20
        CXX_STANDARD_REQUIRED YES
        CXX_EXTENSIONS NO
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        communicator
        ingredient
        recipe
        grpc
        tabetai2_grpc_proto
)

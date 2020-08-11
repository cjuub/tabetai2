project(application)

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/server_factory.h
    src/server_factory.cpp
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        ingredient
        server
        database
)
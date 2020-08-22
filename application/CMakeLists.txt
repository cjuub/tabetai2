project(application)

add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        server
        wamp_publisher
        wamp_session
        warning
)

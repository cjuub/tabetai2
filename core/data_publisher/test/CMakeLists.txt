project(test_data_publisher)

include(Catch)

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/test_repository_publisher.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        data_publisher
        # TODO(robinlinden): Mocking a repository would be cleaner, but we
        # already get this dependency from data_publisher.
        ingredient
        Catch2::Catch2
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

catch_discover_tests(${PROJECT_NAME})

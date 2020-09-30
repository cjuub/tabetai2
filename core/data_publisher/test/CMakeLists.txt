project(test_tabetai_data_publisher)

include(Catch)

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/test_repository_publisher.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        tabetai::data_publisher
        # TODO(robinlinden): Mocking a repository would be cleaner, but we
        # already get this dependency from data_publisher.
        tabetai::ingredient
        Catch2::Catch2
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

catch_discover_tests(${PROJECT_NAME})

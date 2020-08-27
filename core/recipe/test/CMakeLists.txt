project(test_recipe)

include(Catch)

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/test_recipe_repository.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        recipe
        Catch2::Catch2
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

catch_discover_tests(${PROJECT_NAME})

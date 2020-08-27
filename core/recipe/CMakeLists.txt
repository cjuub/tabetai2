project(recipe)

find_package(range-v3 REQUIRED)

add_library(${PROJECT_NAME}
    include/recipe/recipe.h
    include/recipe/recipe_repository.h

    src/recipe.cpp
    src/recipe_repository.cpp
)

target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_std_20
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        repository
        ingredient
    PRIVATE
        warning
        range-v3::range-v3
)

add_subdirectory(test)

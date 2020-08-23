project(recipe)

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
    PRIVATE
        ingredient
        warning
)

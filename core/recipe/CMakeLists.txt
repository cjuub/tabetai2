project(tabetai_recipe)

add_library(${PROJECT_NAME}
    include/recipe/recipe.h
    include/recipe/recipe_repository.h
    include/recipe/unit.h
    include/recipe/quantity.h

    src/recipe.cpp
    src/recipe_repository.cpp
    src/quantity.cpp
)
add_library(tabetai::recipe ALIAS ${PROJECT_NAME})

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
    PUBLIC
        tabetai::repository
        tabetai::ingredient
    PRIVATE
        tabetai::warning
)

add_subdirectory(test)

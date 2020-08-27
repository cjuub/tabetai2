project(yaml_database)

find_package(yaml-cpp REQUIRED)

add_library(${PROJECT_NAME}
    include/yaml_database/yaml_database.hpp
    include/yaml_database/yaml_ingredient_database.h
    include/yaml_database/yaml_recipe_database.h

    src/yaml_ingredient_database.cpp
    src/yaml_recipe_database.cpp
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
        yaml-cpp::yaml-cpp
    PRIVATE
        database
        ingredient
        recipe
)

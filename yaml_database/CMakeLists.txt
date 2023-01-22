project(tabetai_yaml_database)

add_library(${PROJECT_NAME}
    include/yaml_database/yaml_database.hpp
    include/yaml_database/yaml_ingredient_database.h
    include/yaml_database/yaml_recipe_database.h
    include/yaml_database/yaml_schedule_database.h

    src/yaml_ingredient_database.cpp
    src/yaml_recipe_database.cpp
    src/yaml_schedule_database.cpp
)
add_library(tabetai::yaml_database ALIAS ${PROJECT_NAME})

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
        range-v3::range-v3
        yaml-cpp::yaml-cpp
    PRIVATE
        tabetai::database
        tabetai::ingredient
        tabetai::recipe
        tabetai::schedule
        tabetai::warning
)

project(tabetai_ingredient)

find_package(range-v3 REQUIRED)

add_library(${PROJECT_NAME}
    include/ingredient/ingredient.h
    include/ingredient/ingredient_repository.h
    src/ingredient.cpp
    src/ingredient_repository.cpp
)
add_library(tabetai::ingredient ALIAS ${PROJECT_NAME})

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
    PRIVATE
        tabetai::warning
        range-v3::range-v3
)
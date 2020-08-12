project(ingredient)

add_library(${PROJECT_NAME}
    include/ingredient/ingredient.h
    include/ingredient/ingredient_repository.h

    src/ingredient.cpp
    src/ingredient_repository.cpp
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
        database
        repository
    PRIVATE
        warning
)
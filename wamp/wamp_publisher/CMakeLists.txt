project(wamp_publisher)

add_library(${PROJECT_NAME}
    include/wamp_publisher/repository_publisher_factory.h

    src/ingredient_repository_publisher.cpp
    src/ingredient_repository_publisher.h
    src/recipe_repository_publisher.h
    src/recipe_repository_publisher.cpp
    src/repository_publisher_factory.cpp
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

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        data_publisher
        ingredient
        recipe
        wamp_data
        wamp_session
        warning
)

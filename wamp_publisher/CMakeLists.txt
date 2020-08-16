project(wamp_publisher)

add_library(${PROJECT_NAME}
    include/wamp_publisher/repository_publisher_factory.h

    src/ingredient_repository_publisher.cpp
    src/ingredient_repository_publisher.h
    src/repository_publisher_factory.cpp
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
    PRIVATE
        data_publisher
        ingredient
)
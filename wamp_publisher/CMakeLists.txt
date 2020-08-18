project(wamp_publisher)

add_library(${PROJECT_NAME}
    include/wamp_publisher/repository_publisher_factory.h
    include/wamp_publisher/session.h

    src/ingredient_repository_publisher.cpp
    src/ingredient_repository_publisher.h
    src/repository_publisher_factory.cpp
    src/session.cpp
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
        autobahn_cpp
        data_publisher
        ingredient
)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE
        -DBOOST_ASIO_DISABLE_CONCEPTS
)

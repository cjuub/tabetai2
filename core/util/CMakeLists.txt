project(util)

add_library(${PROJECT_NAME}
    include/util/observable.h
    include/util/observer.h
    include/util/publisher.h
    include/util/impl/observable.h
    src/observable.cpp
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
        warning
)

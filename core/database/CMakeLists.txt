project(database)

find_package(range-v3 REQUIRED)

add_library(${PROJECT_NAME}
    include/database/database.h
    include/database/id_generator.h
    include/database/id_generator_factory.h
    include/database/in_memory_database.hpp

    src/id_generator_factory.cpp
    src/impl/id_generator.cpp
    src/impl/id_generator.h
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
        range-v3::range-v3
)

project(tabetai_database)

add_library(${PROJECT_NAME}
    include/database/database.h
    include/database/id_generator.h
    include/database/id_generator_factory.h
    include/database/in_memory_database.hpp

    src/id_generator_factory.cpp
    src/impl/id_generator.cpp
    src/impl/id_generator.h
)
add_library(tabetai::database ALIAS ${PROJECT_NAME})

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

project(tabetai_data_publisher)

add_library(${PROJECT_NAME} INTERFACE)
add_library(tabetai::data_publisher ALIAS ${PROJECT_NAME})

target_compile_features(${PROJECT_NAME}
    INTERFACE
        cxx_std_20
)

target_include_directories(${PROJECT_NAME}
    INTERFACE
        include
)

target_link_libraries(${PROJECT_NAME}
    INTERFACE
        tabetai::ingredient
        tabetai::recipe
        tabetai::repository
        tabetai::schedule
        tabetai::util
        tabetai::warning
)

add_subdirectory(test)

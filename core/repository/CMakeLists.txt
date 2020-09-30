project(tabetai_repository)

add_library(${PROJECT_NAME} INTERFACE)
add_library(tabetai::repository ALIAS ${PROJECT_NAME})

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
        tabetai::database
        tabetai::util
)

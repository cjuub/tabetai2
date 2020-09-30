project(tabetai_wamp_data)

add_library(${PROJECT_NAME} INTERFACE)
add_library(tabetai::wamp_data ALIAS ${PROJECT_NAME})

target_compile_features(${PROJECT_NAME}
    INTERFACE
        cxx_std_20
)

target_include_directories(${PROJECT_NAME}
    INTERFACE
        include
)

project(tabetai_wamp_session)

add_library(${PROJECT_NAME}
    include/wamp_session/wamp_session_factory.h
    include/wamp_session/wamp_session.h

    src/impl/wamp_session.cpp
    src/impl/wamp_session.h
    src/wamp_session_factory.cpp
)
add_library(tabetai::wamp_session ALIAS ${PROJECT_NAME})

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
    PUBLIC
        tabetai::wamp_data
    PRIVATE
        autobahn_cpp
        tabetai::warning::low
)

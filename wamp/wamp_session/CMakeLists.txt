project(wamp_session)

add_library(${PROJECT_NAME}
    include/wamp_session/wamp_session_factory.h
    include/wamp_session/wamp_session.h

    src/impl/wamp_session.cpp
    src/impl/wamp_session.h
    src/wamp_session_factory.cpp
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
        wamp_data
    PRIVATE
        autobahn_cpp
        warning::low
)

project(tabetai_schedule)

add_library(${PROJECT_NAME}
    include/schedule/schedule.h
    include/schedule/schedule_repository.h
    include/schedule/schedule_day.h
    include/schedule/schedule_summary.h
    include/schedule/recipe_meal.h
    include/schedule/external_recipe_meal.h
    include/schedule/leftovers_meal.h
    include/schedule/other_meal.h
    include/schedule/meal.h

    src/schedule.cpp
    src/schedule_repository.cpp
    src/schedule_day.cpp
    src/schedule_summary.cpp
    src/meal.cpp
    src/recipe_meal.cpp
    src/external_recipe_meal.cpp
    src/leftovers_meal.cpp
    src/other_meal.cpp
)

add_library(tabetai::schedule ALIAS ${PROJECT_NAME})

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
        tabetai::recipe
        tabetai::repository
    PRIVATE
        tabetai::warning
)

add_subdirectory(test)

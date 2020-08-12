cmake_minimum_required(VERSION 3.17)

project(tabetai2)

add_subdirectory(warning)

add_subdirectory(core/database)
add_subdirectory(core/ingredient)
add_subdirectory(core/repository)
add_subdirectory(core/server)

add_subdirectory(application)

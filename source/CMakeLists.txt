cmake_minimum_required(VERSION 3.8.2)
# main app that will run on S5/desktop
project(example)

set(CMAKE_EXECUTABLE_LIBRARY_PREFIX)
set(CMAKE_EXECUTABLE_LIBRARY_SUFFIX)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_FLAGS_RELEASE "-O0 -ggdb -g3 -fpic -Wall -std=c++14")# -Werror")
set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -ggdb -g3 -fpic -Wall -std=c++14") # -Werror")
set(CMAKE_C_FLAGS_DEBUG     "-O0 -ggdb -g3 -fpic -Wall") # -shared -Werror")
set(CMAKE_C_FLAGS_RELEASE   "-O0 -fpic -shared -Wall") # -Werror")

link_directories(${CMAKE_PREFIX_PATH}/lib)

set(APP example)
add_executable( ${APP} example.cpp )

add_custom_target(generate_version DEPENDS ${VERSION_HEADER})
add_dependencies(${APP} generate_version)

target_link_libraries(${APP} msgpackc)

install(TARGETS ${APP} DESTINATION bin)


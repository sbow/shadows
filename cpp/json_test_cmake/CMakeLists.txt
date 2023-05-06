cmake_minimum_required(VERSION 3.15)

project(json_test_cmake VERSION 1.0.0 LANGUAGES CXX)

# Enable simple "mkdir build; cd build; cmake .. ect" user experience
# Set default build type to Release if not specified
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(Threads REQUIRED)

add_executable(json_test main.cpp)

# Set the preprocessor definition for the path to 'params.json' when using the Debug configuration
if (CMAKE_BUILD_TYPE MATCHES Debug)
    target_compile_definitions(json_test PRIVATE PARAMS_JSON_PATH="${CMAKE_CURRENT_SOURCE_DIR}/params.json")
endif()

target_link_libraries(json_test PRIVATE Threads::Threads)

# Copy the 'params.json' file to the same destination as the executable binary when using the Release configuration
if (CMAKE_BUILD_TYPE MATCHES Release)
    add_custom_command(TARGET json_test POST_BUILD
                       COMMAND ${CMAKE_COMMAND} -E copy
                       ${CMAKE_CURRENT_SOURCE_DIR}/params.json
                       $<TARGET_FILE_DIR:json_test>/params.json)
endif()
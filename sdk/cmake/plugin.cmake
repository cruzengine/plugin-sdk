function(engine_add_plugin NAME)
    option(${NAME}_BUILD_SHARED "Build plugin as shared library" ON)

    file(GLOB_RECURSE PLUGIN_SOURCES src/*.cpp)

    if(${NAME}_BUILD_SHARED)
        add_library(${NAME} SHARED ${PLUGIN_SOURCES})
        target_compile_definitions(${NAME} PRIVATE ENGINE_PLUGIN_SHARED)
    else()
        list(FILTER PLUGIN_SOURCES EXCLUDE REGEX "PluginEntry.cpp$")
        add_library(${NAME} STATIC ${PLUGIN_SOURCES})
    endif()

    target_include_directories(${NAME} PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${ENGINE_PLUGIN_SDK_ROOT}/include
    )

    target_link_libraries(${NAME} PUBLIC EngineCore)
endfunction()

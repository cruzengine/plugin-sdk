function(cruz_add_plugin NAME)
    string(REPLACE "-" "_" NAME_SAFE "${NAME}")

    option(${NAME_SAFE}_BUILD_SHARED "Build plugin as shared library" ON)

    file(GLOB_RECURSE PLUGIN_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    )

    if(NOT PLUGIN_SOURCES)
        message(FATAL_ERROR "No source files found for plugin ${NAME}")
    endif()

    if(${NAME_SAFE}_BUILD_SHARED)
        add_library(${NAME} SHARED ${PLUGIN_SOURCES})
        target_compile_definitions(${NAME} PRIVATE CRUZ_PLUGIN_SHARED)
    else()
        list(FILTER PLUGIN_SOURCES EXCLUDE REGEX "PluginEntry.cpp$")
        add_library(${NAME} STATIC ${PLUGIN_SOURCES})
    endif()

    target_include_directories(${NAME} PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}/include"
        "${CRUZ_PLUGINSDK}/include"
    )

    target_link_libraries(${NAME} PUBLIC EngineCore)
endfunction()

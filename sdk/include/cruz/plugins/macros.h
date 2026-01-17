#pragma once

#if defined(ENGINE_PLUGIN_SHARED)
#if defined(_WIN32)
#define ENGINE_PLUGIN_EXPORT __declspec(dllexport)
#else
#define ENGINE_PLUGIN_EXPORT __attribute__((visibility("default")))
#endif
#else
#define ENGINE_PLUGIN_EXPORT
#endif

#define ENGINE_DECLARE_PLUGIN(ClassName) \
    extern "C" ENGINE_PLUGIN_EXPORT Engine::Plugin* CreatePlugin() { \
        static ClassName plugin; \
        return &plugin; \
    }

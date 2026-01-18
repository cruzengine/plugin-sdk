#pragma once

#if defined(CRUZ_PLUGIN_SHARED)
#if defined(_WIN32)
#define CRUZ_PLUGIN_EXPORT __declspec(dllexport)
#else
#define CRUZ_PLUGIN_EXPORT __attribute__((visibility("default")))
#endif
#else
#define CRUZ_PLUGIN_EXPORT
#endif

#define CRUZ_DECLARE_PLUGIN(ClassName) \
    extern "C" CRUZ_PLUGIN_EXPORT Cruz::Plugin* CreatePlugin() { \
        static ClassName plugin; \
        return &plugin; \
    }

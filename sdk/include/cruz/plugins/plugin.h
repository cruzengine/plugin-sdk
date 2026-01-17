#pragma once

namespace Cruz {

    class Plugin {
    public:
        virtual ~Plugin() = default;
        virtual void onLoad() {}
        virtual void onUnload() {}
    };

}
#pragma once

#include <wamp_data/publishable.h>

#include <functional>
#include <string>
#include <variant>

namespace tabetai2::wamp_session {

class WampSession {
public:
    virtual void run(std::function<void()> func) = 0;

    virtual void publish(const std::string& topic, const wamp_data::Publishable& object) = 0;

    virtual ~WampSession() = default;
};

}

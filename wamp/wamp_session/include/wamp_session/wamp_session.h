#pragma once

#include <functional>
#include <string>
#include <variant>

namespace tabetai2::wamp_session {

using Publishable = std::variant<std::vector<std::string>>;

class WampSession {
public:
    virtual void run(std::function<void()> func) = 0;

    virtual void publish(const std::string& topic, const Publishable& object) = 0;

    virtual ~WampSession() = default;
};

}
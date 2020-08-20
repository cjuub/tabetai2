#pragma once

#include <wamp_publisher/wamp_session.h>

#include <autobahn/autobahn.hpp>

#include <functional>
#include <memory>

namespace tabetai2::wamp_publisher::impl {

class WampSession : public wamp_publisher::WampSession {
public:
    void run(std::function<void()> func) override;

    void publish(const std::string& topic, const Publishable& object) override;

private:
    std::shared_ptr<autobahn::wamp_session> m_session;
};

}

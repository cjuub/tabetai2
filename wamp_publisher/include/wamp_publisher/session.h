#pragma once

#include <autobahn/wamp_session.hpp>

#include <memory>

namespace tabetai2::wamp_publisher {

class Session {
public:
    void run(std::function<void()> func);

    std::shared_ptr<autobahn::wamp_session> session();

private:
    std::shared_ptr<autobahn::wamp_session> m_session;
};

}

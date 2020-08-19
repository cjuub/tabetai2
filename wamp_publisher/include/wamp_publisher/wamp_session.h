#pragma once

#include <functional>
#include <memory>

namespace autobahn {
class wamp_session;
}

namespace tabetai2::wamp_publisher {

class WampSession {
public:
    void run(std::function<void()> func);

    std::shared_ptr<autobahn::wamp_session> session();

private:
    std::shared_ptr<autobahn::wamp_session> m_session;
};

}

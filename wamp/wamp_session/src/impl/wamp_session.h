#pragma once

#include <wamp_session/wamp_session.h>

#include <autobahn/autobahn.hpp>

#include <functional>
#include <memory>

namespace tabetai2::wamp_session::impl {

class WampSession : public wamp_session::WampSession {
public:
    void run(std::function<void(wamp_session::WampSession&)> func) override;

    void publish(const std::string& topic, const wamp_data::Publishable& object) override;

private:
    void create_rpc_impl(const std::string& topic, const std::function<void(std::vector<std::any>)>& rpc) override;

    std::shared_ptr<autobahn::wamp_session> m_session;
};

}

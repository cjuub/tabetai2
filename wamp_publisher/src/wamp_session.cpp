#include "wamp_publisher/wamp_session.h"

#include <autobahn/autobahn.hpp>

namespace tabetai2::wamp_publisher {

std::shared_ptr<autobahn::wamp_session> WampSession::session() {
    return m_session;
}

void WampSession::run(std::function<void()> func) {
    try {
        boost::asio::io_service io;
        bool debug = true;

        auto m_rawsocket_endpoint = boost::asio::ip::tcp::endpoint(
                boost::asio::ip::address::from_string("127.0.0.1"), 8000);

        auto transport = std::make_shared<autobahn::wamp_tcp_transport>(
                io, m_rawsocket_endpoint, debug);

        m_session = std::make_shared<autobahn::wamp_session>(io, debug);

        transport->attach(std::static_pointer_cast<autobahn::wamp_transport_handler>(m_session));

        boost::future<void> connect_future;
        boost::future<void> start_future;
        boost::future<void> join_future;
        boost::future<void> leave_future;
        boost::future<void> stop_future;

        connect_future = transport->connect().then([&](boost::future<void> connected) {
            try {
                connected.get();
            } catch (const std::exception& e) {
                std::cerr << e.what() << std::endl;
                io.stop();
                return;
            }

            std::cerr << "transport connected" << std::endl;
            start_future = m_session->start().then([&](boost::future<void> started) {
                try {
                    started.get();
                } catch (const std::exception& e) {
                    std::cerr << e.what() << std::endl;
                    io.stop();
                    return;
                }

                std::cerr << "session started" << std::endl;
                join_future = m_session->join("realm1").then([&](boost::future<uint64_t> joined) {
                    try {
                        std::cerr << "joined realm: " << joined.get() << std::endl;
                    } catch (const std::exception& e) {
                        std::cerr << e.what() << std::endl;
                        io.stop();
                        return;
                    }

                    func();
                });
            });
        });

        io.run();
    } catch (const std::exception& e) {
        std::cerr << "exception: " << e.what() << std::endl;
    }
}

}
#include "wamp_session.h"

namespace tabetai2::wamp_session::impl {

using namespace wamp_data;

void WampSession::run(std::function<void(wamp_session::WampSession&)> func) {
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

                try {
                    func(*this);
                } catch (const std::exception& e) {
                    io.stop();
                    throw;
                }
            });
        });
    });

    io.run();

    join_future.wait();
    if (join_future.has_exception()) {
        boost::rethrow_exception(join_future.get_exception_ptr());
    }
}

void WampSession::publish(const std::string& topic, const Publishable& object) {
    std::visit([&](auto& arg) { m_session->publish(topic, arg); }, object);
}

void WampSession::create_rpc_impl(const std::string& topic, const std::function<void(std::vector<std::any>)>& rpc) {
    m_session->provide(topic, [rpc](const autobahn::wamp_invocation& invocation) {
        std::vector<msgpack::object> oh{invocation->number_of_arguments()};
        invocation->get_arguments(oh);
        std::vector<std::any> args;

        std::function<std::any(msgpack::object)> fun = [&](msgpack::object o) {
            std::any arg;
            switch (o.type) {
                case msgpack::v1::type::BOOLEAN:
                    arg = o.as<bool>(); break;
                case msgpack::v1::type::POSITIVE_INTEGER:
                case msgpack::v1::type::NEGATIVE_INTEGER:
                    arg = o.as<int>(); break;
                case msgpack::v1::type::FLOAT32:
                    arg = o.as<float>(); break;
                case msgpack::v1::type::FLOAT64:
                    arg = o.as<double>(); break;
                case msgpack::v1::type::STR:
                    arg = o.as<std::string>(); break;
                case msgpack::v1::type::MAP:
                    // TODO this will break very very fast
                    arg = o.as<std::map<std::string, std::pair<int, int>>>(); break;
                case msgpack::v1::type::ARRAY:
                    // TODO this will break very very fast
                    arg = o.as<std::vector<std::string>>(); break;
                case msgpack::v1::type::BIN:
                case msgpack::v1::type::EXT:
                case msgpack::v1::type::NIL:
                    throw std::runtime_error{"not supported"};
            }

            return arg;
        };

        std::transform(oh.cbegin(), oh.cend(), std::back_inserter(args), [fun](msgpack::object o) { return fun(o); });

        rpc(args);
    });
}

}

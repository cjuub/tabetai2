#include "server/server_factory.h"

#include <wamp_publisher/repository_publisher_factory.h>
#include <wamp_session/wamp_session_factory.h>

using namespace tabetai2::core::server;
using namespace tabetai2::wamp_publisher;
using namespace tabetai2::wamp_session;

int main() {
    auto session = WampSessionFactory::create();
    session->run([&]() {
        ServerFactory(std::make_unique<RepositoryPublisherFactory>(*session)).create()->run();
    });
}

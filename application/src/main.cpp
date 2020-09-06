#include "server/server_factory.h"

#include <database/id_generator_factory.h>
#include <wamp_publisher/repository_publisher_factory.h>
#include <wamp_session/wamp_session_factory.h>

using namespace tabetai2::core::database;
using namespace tabetai2::core::server;
using namespace tabetai2::wamp_publisher;
using namespace tabetai2::wamp_session;

int main() {
    std::unique_ptr<Server> server;
    WampSessionFactory::create()->run([&](WampSession& session) {
        auto id_generator = IdGeneratorFactory::create();
        server = ServerFactory(std::make_unique<RepositoryPublisherFactory>(session, id_generator)).create();
        server->run();
    });
}

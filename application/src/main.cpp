#include "server/server_factory.h"

#include <wamp_publisher/repository_publisher_factory.h>

using namespace tabetai2::core::server;
using namespace tabetai2::wamp_publisher;

int main() {
    auto repository_publisher_factory = std::make_unique<RepositoryPublisherFactory>();
    ServerFactory(std::move(repository_publisher_factory)).create()->run();
}

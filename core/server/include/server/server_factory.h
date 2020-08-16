#pragma once

#include "server/server.h"

#include <data_publisher/repository_publisher_factory.h>

#include <memory>

namespace tabetai2::core::server {

class ServerFactory {
public:
    explicit ServerFactory(std::unique_ptr<data_publisher::RepositoryPublisherFactory> repository_publisher_factory);

    std::unique_ptr<core::server::Server> create() const;

private:
    std::unique_ptr<data_publisher::RepositoryPublisherFactory> m_repository_publisher_factory;
};

}

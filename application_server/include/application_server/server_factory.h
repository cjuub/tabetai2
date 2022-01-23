#pragma once

#include <server/server_factory.h>

#include <data_publisher/publisher.h>
#include <data_publisher/repository_publisher_factory.h>

namespace tabetai2::application_server {

class ServerFactory : public core::server::ServerFactory {
public:
    ServerFactory() = default;

    std::unique_ptr<core::server::Server> create() const override;
};

}
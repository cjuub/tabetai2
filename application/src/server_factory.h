#pragma once

#include <server/server.h>
#include <server/server_factory.h>

#include <memory>

namespace tabetai2::application {

class ServerFactory : core::server::ServerFactory {
public:
    std::unique_ptr<core::server::Server> create() override;
};

}
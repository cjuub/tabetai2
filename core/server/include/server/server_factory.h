#pragma once

#include <data_publisher/repository_publisher_factory.h>

#include <memory>

#include "server/server.h"

namespace tabetai2::core::server {

class ServerFactory {
public:
    virtual std::unique_ptr<core::server::Server> create() const = 0;
    virtual ~ServerFactory() = default;
};

}  // namespace tabetai2::core::server

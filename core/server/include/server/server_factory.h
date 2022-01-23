#pragma once

#include "server/server.h"

#include <data_publisher/repository_publisher_factory.h>

#include <memory>

namespace tabetai2::core::server {

class ServerFactory {
public:
    virtual std::unique_ptr<core::server::Server> create() const = 0;
    virtual ~ServerFactory() = default;
};

}

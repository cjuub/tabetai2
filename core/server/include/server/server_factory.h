#pragma once

#include "server/server.h"

#include <memory>

namespace tabetai2::core::server {

class ServerFactory {
public:
    virtual ~ServerFactory() = default;
    virtual std::unique_ptr<Server> create() const = 0;
};

}

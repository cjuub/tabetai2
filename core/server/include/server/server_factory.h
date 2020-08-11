#pragma once

#include "server/server.h"

#include <memory>

namespace tabetai2::core::server {

class ServerFactory {
public:
    virtual std::unique_ptr<Server> create() = 0;
};

}
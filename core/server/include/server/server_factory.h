#pragma once

#include "server/server.h"

#include <memory>

namespace tabetai2::core::server {

class ServerFactory {
public:
    std::unique_ptr<core::server::Server> create() const;
};

}

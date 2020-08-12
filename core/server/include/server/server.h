#pragma once

namespace tabetai2::core::server {

class Server {
public:
    virtual ~Server() = default;
    virtual void run() = 0;
};

}

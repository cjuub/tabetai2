#pragma once

namespace tabetai2::core::communicator {

class Communicator {
public:
    virtual void run() = 0;
    virtual ~Communicator() = default;
};

}

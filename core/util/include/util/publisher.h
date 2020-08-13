#pragma once

namespace tabetai2::core::util {

class Publisher {
public:
    virtual void publish() = 0;

    virtual ~Publisher() = default;
};

}

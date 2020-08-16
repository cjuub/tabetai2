#pragma once

namespace tabetai2::core::data_publisher {

class Publisher {
public:
    virtual void publish() = 0;

    virtual ~Publisher() = default;
};

}

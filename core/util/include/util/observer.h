#pragma once

namespace tabetai2::core::util {
class Observer {
public:
    virtual void notify() = 0;

    virtual ~Observer() = default;
};
}

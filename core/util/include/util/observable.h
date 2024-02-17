#pragma once

namespace tabetai2::core::util {

class Observable {
public:
    virtual void notify_observers() = 0;

    virtual ~Observable() = default;
};

}  // namespace tabetai2::core::util

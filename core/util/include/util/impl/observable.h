#pragma once

#include <util/observable.h>
#include <util/observer.h>

#include <vector>

namespace tabetai2::core::util::impl {

class Observable : public util::Observable {
public:
    void add_observer(util::Observer* observer);

protected:
    void notify_observers() override;

private:
    std::vector<util::Observer*> m_observers;
};

}
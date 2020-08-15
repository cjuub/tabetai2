#include <util/impl/observable.h>

namespace tabetai2::core::util::impl {

void Observable::add_observer(util::Observer* const observer) {
    m_observers.push_back(observer);
}

void Observable::notify_observers() {
    for (auto observer : m_observers) {
        observer->notify();
    }
}

}

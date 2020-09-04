#include <util/impl/observable.h>

namespace tabetai2::core::util::impl {

void Observable::add_observer(util::Observer* const observer) {
    m_observers.push_back(observer);
}

void Observable::remove_observer(const util::Observer* const observer) {
    std::erase(m_observers, observer);
}

void Observable::notify_observers() {
    for (auto observer : m_observers) {
        observer->notify();
    }
}

}

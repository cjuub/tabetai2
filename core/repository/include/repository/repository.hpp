#pragma once

#include <database/database.hpp>
#include <util/observable.h>
#include <util/observer.h>

#include <memory>

namespace tabetai2::core::repository {

template<class T>
class Repository : public util::Observable {
public:
    explicit Repository(std::unique_ptr<database::Database<T>> database) : m_database(std::move(database)) {}

    void add(const T& ingredient) {
        m_database->add(ingredient);
        notify_observers();
    }

    void erase(const T& ingredient) {
        m_database->erase(ingredient);
        notify_observers();
    }

    void add_observer(util::Observer* const observer) {
        m_observers.push_back(observer);
    }

protected:
    void notify_observers() override {
        for (auto observer : m_observers) {
            observer->notify();
        }
    }

    std::unique_ptr<database::Database<T>> m_database;
    std::vector<util::Observer*> m_observers;
};

}

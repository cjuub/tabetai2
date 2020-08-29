#pragma once

#include <database/in_memory_database.hpp>
#include <util/impl/observable.h>

#include <memory>
#include <utility>

namespace tabetai2::core::repository {

template<class T>
class Repository : public util::impl::Observable {
public:
    explicit Repository(std::unique_ptr<database::Database<T>> database) : m_database{std::move(database)} {}

    void add(T t) {
        m_database->add(std::move(t));
        notify_observers();
    }

    void erase(int id) {
        m_database->erase(id);
        notify_observers();
    }

    std::vector<T> find_all() const {
        return m_database->get_all();
    }

protected:
    std::unique_ptr<database::Database<T>> m_database;
};

}

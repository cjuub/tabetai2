#pragma once

#include <database/database.hpp>

#include <memory>

namespace tabetai2::core::repository {

template<class T>
class Repository {
public:
    explicit Repository(std::unique_ptr<database::Database<T>> database) : m_database(std::move(database)) {}

    void add(const T& ingredient) {
        m_database->add(ingredient);
    }

    void erase(const T& ingredient) {
        m_database->erase(ingredient);
    }

protected:
    std::unique_ptr<database::Database<T>> m_database;
};

}

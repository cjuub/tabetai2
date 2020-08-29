#pragma once

#include "database.h"

#include <range/v3/view/map.hpp>
#include <range/v3/to_container.hpp>

#include <unordered_map>

namespace tabetai2::core::database {

template<class T>
class InMemoryDatabase : public Database<T> {
public:
    void add(T t) override {
        m_database.emplace(t.id(), std::move(t));
    };

    void erase(int id) override {
        m_database.erase(id);
    };

    T get(int id) const override {
        return m_database.at(id);
    }

    std::vector<T> get_all() const override {
        return m_database | ranges::views::values | ranges::to<std::vector>();
    }

private:
    std::unordered_map<int, T> m_database;
};

}

#pragma once

#include "database.h"

#include <unordered_map>

namespace tabetai2::core::database {

template<class T>
class InMemoryDatabase : public Database<T> {
public:
    InMemoryDatabase() : m_database{} {}

    void add(T t) override {
        m_database.emplace(t.id(), std::move(t));
    };

    void erase(const T& t) override {
        m_database.erase(t.id());
    };

    T get(int id) const override {
        return m_database.at(id);
    }

    std::vector<T> get_all() const override {
        std::vector<T> entries;
        for (auto& entry : m_database) {
            entries.push_back(entry.second);
        }

        return entries;
    }

private:
    std::unordered_map<int, T> m_database;
};

}

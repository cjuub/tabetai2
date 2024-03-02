#pragma once

#include <ranges>
#include <unordered_map>

#include "database.h"

namespace tabetai2::core::database {

template <class T>
class InMemoryDatabase : public Database<T> {
public:
    void add(T t) override {
        m_database.emplace(t.id(), std::move(t));
    };

    void erase(Id id) override {
        m_database.erase(id);
    };

    T get(Id id) const override {
        return m_database.at(id);
    }

    std::vector<T> get_all() const override {
        std::vector<T> res;
        for (const auto& e : m_database | std::ranges::views::values) {
            res.push_back(e);
        }
        return res;
    }

private:
    std::unordered_map<Id, T> m_database;
};

}  // namespace tabetai2::core::database

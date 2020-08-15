#pragma once

#include <unordered_map>
#include <vector>

namespace tabetai2::core::database {

template<class T>
class Database {
public:
    void add(T t) {
        m_database.emplace(t.id(), std::move(t));
    };

    void erase(const T& t) {
        m_database.erase(t.id());
    };

    T get(int id) const {
        return m_database.at(id);
    }

    std::vector<T> get_all() const {
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

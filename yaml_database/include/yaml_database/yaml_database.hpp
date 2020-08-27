#pragma once

#include <database/database.h>

#include <range/v3/to_container.hpp>
#include <range/v3/view/transform.hpp>
#include <yaml-cpp/yaml.h>

#include <fstream>
#include <string>

namespace tabetai2::yaml_database {

template<class T>
class YamlDatabase : public core::database::Database<T> {
public:
    explicit YamlDatabase(std::string database_file, std::string database_name)
    : m_database_file(std::move(database_file)),
      m_database_name(std::move(database_name)),
      m_database() {
        try {
            m_database = YAML::LoadFile(m_database_file);
        } catch (...) {

        }
    }

    void add(T t) override {
        m_database[m_database_name][std::to_string(t.id())] = to_yaml(t);
        commit_changes();
    }

    void erase(int id) override {
        m_database[m_database_name].remove(std::to_string(id));
        commit_changes();
    }

    T get(int id) const override {
        return from_yaml(m_database[m_database_name][std::to_string(id)]);
    }

    std::vector<T> get_all() const override {
        auto db = m_database[m_database_name];
        return db | ranges::views::transform([&](auto y) { return from_yaml(y.second); }) | ranges::to<std::vector>();
    }

protected:
    virtual T from_yaml(YAML::Node entry) const = 0;

    virtual YAML::Node to_yaml(const T& t) const = 0;

private:
    void commit_changes() {
        std::ofstream fs;
        fs.open(m_database_file, std::ios::out);
        if (fs.is_open()) {
            fs << m_database;
            fs.close();
        }
    }

    std::string m_database_file;
    std::string m_database_name;
    YAML::Node m_database;
};

}

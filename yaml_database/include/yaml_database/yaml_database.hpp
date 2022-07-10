#pragma once

#include <database/database.h>
#include <database/id_generator.h>

#include <range/v3/range/conversion.hpp>
#include <range/v3/view/transform.hpp>
#include <yaml-cpp/yaml.h>

#include <filesystem>
#include <fstream>
#include <string>

namespace tabetai2::yaml_database {

template<class T>
class YamlDatabase : public core::database::Database<T> {
public:
    explicit YamlDatabase(std::string database_file, std::string database_name)
    : m_database_file{std::move(database_file)},
      m_database_name{std::move(database_name)},
      m_database() {
        std::string current_version = "1.0";
        if (std::filesystem::exists(m_database_file)) {
            m_database = YAML::LoadFile(m_database_file);
        } else {
            m_database["version"] = current_version;
            commit_changes();
        }

        if (!m_database["version"].IsDefined() || m_database["version"].as<std::string>() != current_version) {
            throw std::runtime_error("Incompatible database file");
        }
    }

    void add(T t) override {
        m_database[m_database_name][std::to_string(t.id())] = to_yaml(t);
        commit_changes();
    }

    void erase(core::database::Id id) override {
        m_database[m_database_name].remove(std::to_string(id));
        commit_changes();
    }

    T get(core::database::Id id) const override {
        auto entry = m_database[m_database_name][std::to_string(id)];
        if (!entry.IsDefined()) {
            throw std::out_of_range("Access to ID not in database");
        }
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

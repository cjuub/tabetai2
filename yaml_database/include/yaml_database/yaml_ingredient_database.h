#pragma once

#include <database/database.h>
#include <ingredient/ingredient.h>

#include <yaml-cpp/yaml.h>

#include <string>

namespace tabetai2::yaml_database {

class YamlIngredientDatabase : public core::database::Database<core::ingredient::Ingredient> {
public:
    explicit YamlIngredientDatabase(std::string database_file);

    void add(core::ingredient::Ingredient ingredient) override;

    void erase(const core::ingredient::Ingredient& ingredient) override;

    core::ingredient::Ingredient get(int id) const override;

    std::vector<core::ingredient::Ingredient> get_all() const override;

private:
    void _commit_changes();

    std::string m_database_file;
    YAML::Node m_database;
};

}

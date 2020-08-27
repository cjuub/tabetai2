#pragma once

#include <yaml_database/yaml_database.hpp>
#include <ingredient/ingredient_repository.h>
#include <recipe/recipe.h>

namespace tabetai2::yaml_database {

class YamlRecipeDatabase : public YamlDatabase<core::recipe::Recipe> {
public:
    YamlRecipeDatabase(std::string database_file,
                       std::string database_name,
                       std::shared_ptr<core::ingredient::IngredientRepository> ingredient_repository);

    core::recipe::Recipe from_yaml(YAML::Node entry) const override;

    YAML::Node to_yaml(const core::recipe::Recipe& recipe) const override;

private:
    std::shared_ptr<core::ingredient::IngredientRepository> m_ingredient_repository;
};

}

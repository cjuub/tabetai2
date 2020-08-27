#pragma once

#include <yaml_database/yaml_database.hpp>
#include <ingredient/ingredient.h>

namespace tabetai2::yaml_database {

class YamlIngredientDatabase : public YamlDatabase<core::ingredient::Ingredient> {
public:
    using YamlDatabase<core::ingredient::Ingredient>::YamlDatabase;

    core::ingredient::Ingredient from_yaml(YAML::Node entry) const override;

    YAML::Node to_yaml(const core::ingredient::Ingredient& ingredient) const override;
};

}

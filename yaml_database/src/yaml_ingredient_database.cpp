#include <yaml_database/yaml_ingredient_database.h>

namespace tabetai2::yaml_database {

using namespace core::ingredient;

core::ingredient::Ingredient YamlIngredientDatabase::from_yaml(YAML::Node entry) const {
    return Ingredient(entry["id"].as<int>(), entry["name"].as<std::string>());
}

YAML::Node YamlIngredientDatabase::to_yaml(const core::ingredient::Ingredient& ingredient) const {
    YAML::Node entry;
    entry["id"] = ingredient.id();
    entry["name"] = ingredient.name();
    return entry;
}

}

#include <yaml_database/yaml_recipe_database.h>

#include <string>

namespace tabetai2::yaml_database {

using namespace core::ingredient;
using namespace core::recipe;

YamlRecipeDatabase::YamlRecipeDatabase(std::string database_file,
                                       std::string database_name,
                                       std::shared_ptr<IngredientRepository> ingredient_repository)
: YamlDatabase<core::recipe::Recipe>(std::move(database_file), std::move(database_name)),
  m_ingredient_repository(std::move(ingredient_repository)) {

}

Recipe YamlRecipeDatabase::from_yaml(YAML::Node entry) const {
    std::vector<Ingredient> ingredients;
    for (const auto& id : entry["ingredients"]) {
        auto ingredient = m_ingredient_repository->find_by_id(id.as<int>());
        if (ingredient) {
            ingredients.push_back(ingredient.value());
        } else {
            // TODO non-existing ingredient referenced in recipe, what do?
        }
    }

    return Recipe(entry["id"].as<int>(),
                  entry["name"].as<std::string>(),
                  ingredients,
                  entry["steps"].as<std::vector<std::string>>());
}

YAML::Node YamlRecipeDatabase::to_yaml(const Recipe& recipe) const {
    YAML::Node entry;
    entry["id"] = recipe.id();
    entry["name"] = recipe.name();

    std::vector<int> ingredient_ids;
    for (const auto& ingredient : recipe.ingredients()) {
        ingredient_ids.push_back(ingredient.id());
    }

    entry["ingredients"] = ingredient_ids;
    entry["steps"] = recipe.steps();

    return entry;
}

}

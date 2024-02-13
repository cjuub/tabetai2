#include <yaml_database/yaml_recipe_database.h>

#include <iostream>
#include <string>

namespace tabetai2::yaml_database {

using namespace core::database;
using namespace core::ingredient;
using namespace core::recipe;

YamlRecipeDatabase::YamlRecipeDatabase(std::string database_file,
                                       std::string database_name,
                                       std::shared_ptr<IngredientRepository> ingredient_repository)
: YamlDatabase<core::recipe::Recipe>{std::move(database_file), std::move(database_name)},
  m_ingredient_repository{std::move(ingredient_repository)} {

}

Recipe YamlRecipeDatabase::from_yaml(YAML::Node entry) const {
    std::vector<std::pair<Ingredient, std::optional<Quantity>>> ingredients;
    for (const auto& ingredient_entry : entry["ingredients"]) {
        auto id = ingredient_entry.first.as<Id>();
        auto ingredient = m_ingredient_repository->find_by_id(id);
        if (!ingredient) {
            std::cout << "Non-existing ingredient referenced in recipe." << std::endl;
        }

        auto ingredient_data = ingredient_entry.second;
        auto amount = ingredient_data["amount"].as<double>();
        auto unit = static_cast<Unit>(ingredient_data["unit"].as<int>());
        ingredients.emplace_back(*ingredient, Quantity(amount, unit));
    }

    return Recipe{entry["id"].as<Id>(),
                  entry["name"].as<std::string>(),
                  entry["servings"].as<unsigned>(),
                  std::move(ingredients),
                  entry["steps"].as<std::vector<std::string>>()};
}

YAML::Node YamlRecipeDatabase::to_yaml(const Recipe& recipe) const {
    YAML::Node entry;
    entry["id"] = recipe.id();
    entry["name"] = recipe.name();
    entry["servings"] = recipe.servings();

    for (const auto& ingredient : recipe.ingredients()) {
        entry["ingredients"][ingredient.first.id()]["amount"] = ingredient.second->amount();
        entry["ingredients"][ingredient.first.id()]["unit"] = static_cast<int>(ingredient.second->unit());
    }

    entry["steps"] = recipe.steps();

    return entry;
}

}

#include <yaml_database/yaml_recipe_database.h>

#include <string>

namespace tabetai2::yaml_database {

using namespace core::ingredient;
using namespace core::recipe;

using SerializedIngredient = std::map<int, std::pair<unsigned, int>>;

YamlRecipeDatabase::YamlRecipeDatabase(std::string database_file,
                                       std::string database_name,
                                       std::shared_ptr<IngredientRepository> ingredient_repository)
: YamlDatabase<core::recipe::Recipe>(std::move(database_file), std::move(database_name)),
  m_ingredient_repository(std::move(ingredient_repository)) {

}

Recipe YamlRecipeDatabase::from_yaml(YAML::Node entry) const {
    std::vector<std::pair<Ingredient, std::optional<Quantity>>> ingredients;
    for (const auto& ingredient_entry : entry["ingredients"].as<std::vector<SerializedIngredient>>()) {
        auto id = ingredient_entry.begin()->first;
        auto quantity = ingredient_entry.at(id);

        auto ingredient = m_ingredient_repository->find_by_id(id);
        if (ingredient) {
            auto amount = quantity.first;
            auto unit = static_cast<Unit>(quantity.second);
            ingredients.emplace_back(*ingredient,Quantity(amount, unit));
        } else {
            // TODO non-existing ingredient referenced in recipe, what do?
        }
    }

    return Recipe(entry["id"].as<int>(),
                  entry["name"].as<std::string>(),
                  std::move(ingredients),
                  entry["steps"].as<std::vector<std::string>>());
}

YAML::Node YamlRecipeDatabase::to_yaml(const Recipe& recipe) const {
    YAML::Node entry;
    entry["id"] = recipe.id();
    entry["name"] = recipe.name();

    std::vector<SerializedIngredient> ingredients;
    for (const auto& ingredient : recipe.ingredients()) {
        SerializedIngredient serialized_ingredient;
        serialized_ingredient[ingredient.first.id()] =
                std::make_pair(ingredient.second->amount(), static_cast<int>(ingredient.second->unit()));
        ingredients.push_back(std::move(serialized_ingredient));
    }

    entry["ingredients"] = ingredients;
    entry["steps"] = recipe.steps();

    return entry;
}

}

#include <recipe/recipe_repository.h>

namespace tabetai2::core::recipe {

using namespace ingredient;

std::optional<Recipe> RecipeRepository::find_by_id(int id) const {
    return m_database->get(id);
}

std::optional<Recipe> RecipeRepository::find_by_name(const std::string& name) const {
    auto recipes = m_database->get_all();

    for (auto& recipe : recipes) {
        if (recipe.name() == name) {
            return recipe;
        }
    }

    return {};
}

std::optional<std::vector<Recipe>> RecipeRepository::find_by_ingredients(
        const std::vector<Ingredient>& ingredients) const {
    auto recipes = m_database->get_all();

    // TODO Use some std algorithm instead?
    std::vector<Recipe> recipes_found;
    for (auto& recipe : recipes) {
        for (auto& recipe_ingredient : recipe.ingredients()) {
            bool found_all = true;
            for (auto& ingredient : ingredients) {
                if (recipe_ingredient.id() != ingredient.id()) {
                    found_all = false;
                    break;
                }
            }

            if (found_all) {
                recipes_found.push_back(recipe);
            }
        }
    }

    if (recipes_found.empty()) {
        return {};
    }

    return recipes;
}

}

#include <recipe/recipe_repository.h>

#include <algorithm>
#include <stdexcept>

namespace tabetai2::core::recipe {

using namespace core::ingredient;
using namespace core::database;

std::optional<Recipe> RecipeRepository::find_by_id(Id id) const try {
    return m_database->get(id);
} catch (const std::out_of_range &) {
    return std::nullopt;
}

std::optional<Recipe> RecipeRepository::find_by_name(const std::string &name) const {
    auto recipes = m_database->get_all();
    auto it = std::ranges::find_if(recipes, [&](const auto &r) { return r.name() == name; });
    return it == recipes.end() ? std::nullopt : std::make_optional(*it);
}

std::optional<std::vector<Recipe>> RecipeRepository::find_by_ingredients(
    const std::vector<Ingredient> &ingredients) const {
    auto is_missing_ingredients = [&](const Recipe &r) {
        return std::ranges::any_of(r.ingredients(), [&](const auto &i) {
            return std::ranges::find_if(ingredients, [&](const auto &repo_ingredient) {
                       return i.first.id() == repo_ingredient.id();
                   }) == std::end(ingredients);
        });
    };

    auto recipes = m_database->get_all();
    auto ret = std::ranges::remove_if(recipes, is_missing_ingredients);
    recipes.erase(ret.begin(), ret.end());
    return recipes.empty() ? std::nullopt : std::make_optional(recipes);
}

}  // namespace tabetai2::core::recipe

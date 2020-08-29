#include <recipe/recipe_repository.h>

#include <range/v3/algorithm/any_of.hpp>
#include <range/v3/algorithm/find_if.hpp>
#include <range/v3/action/remove_if.hpp>

#include <stdexcept>

namespace tabetai2::core::recipe {

using namespace ingredient;

std::optional<Recipe> RecipeRepository::find_by_id(int id) const try {
    return m_database->get(id);
} catch (const std::out_of_range&) {
    return std::nullopt;
}

std::optional<Recipe> RecipeRepository::find_by_name(const std::string& name) const {
    auto recipes = m_database->get_all();
    auto it = ranges::find_if(recipes, [&](const auto &r) { return r.name() == name; });
    return it == recipes.end() ? std::nullopt : std::make_optional(*it);
}

std::optional<std::vector<Recipe>> RecipeRepository::find_by_ingredients(
        const std::vector<Ingredient>& ingredients) const {

    auto is_missing_ingredients = [&](const Recipe &r) {
        return ranges::any_of(r.ingredients(), [&](const auto &i) {
            return ranges::find_if(ingredients, [&](const auto &repo_ingredient) {
                return i.first.id() == repo_ingredient.id();
            }) == std::end(ingredients);
        });
    };

    auto recipes = m_database->get_all();
    recipes |= ranges::actions::remove_if(is_missing_ingredients);
    return recipes.empty() ? std::nullopt : std::make_optional(recipes);
}

}

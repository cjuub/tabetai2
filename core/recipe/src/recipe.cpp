#include <recipe/recipe.h>

#include <utility>

namespace tabetai2::core::recipe {

using namespace core::database;
using namespace core::ingredient;

Recipe::Recipe(Id id,
               std::string name,
               unsigned servings,
               std::vector<std::pair<Ingredient, std::optional<Quantity>>> ingredients,
               std::vector<std::string> steps) :
m_id{id},
m_name{std::move(name)},
m_servings{servings},
m_ingredients{std::move(ingredients)},
m_steps{std::move(steps)} {}

Id Recipe::id() const {
    return m_id;
}

std::string Recipe::name() const {
    return m_name;
}

unsigned Recipe::servings() const {
    return m_servings;
}

std::vector<std::pair<ingredient::Ingredient, std::optional<Quantity>>> Recipe::ingredients() const {
    return m_ingredients;
}

std::vector<std::string> Recipe::steps() const {
    return m_steps;
}

}  // namespace tabetai2::core::recipe

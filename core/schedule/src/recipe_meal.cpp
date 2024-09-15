#include <schedule/recipe_meal.h>

#include <utility>

namespace tabetai2::core::schedule {

using namespace recipe;

RecipeMeal::RecipeMeal(Recipe recipe, unsigned servings, std::string comment) :
Meal{MealType::Recipe, recipe.name(), servings, comment}, m_recipe{std::move(recipe)} {}

Recipe RecipeMeal::recipe() const {
    return m_recipe;
}

}  // namespace tabetai2::core::schedule

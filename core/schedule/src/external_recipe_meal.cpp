#include <schedule/external_recipe_meal.h>

#include <utility>

namespace tabetai2::core::schedule {

using namespace recipe;

ExternalRecipeMeal::ExternalRecipeMeal(std::string title, std::string url, unsigned servings, std::string comment) :
Meal{MealType::ExternalRecipe, std::move(title), servings, comment}, m_url{std::move(url)} {}

std::string ExternalRecipeMeal::url() const {
    return m_url;
}

}  // namespace tabetai2::core::schedule

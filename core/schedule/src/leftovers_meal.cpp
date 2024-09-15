#include <schedule/leftovers_meal.h>

#include <utility>

namespace tabetai2::core::schedule {

LeftoversMeal::LeftoversMeal(std::string title, unsigned servings, std::string comment) :
Meal{MealType::Leftovers, std::move(title), servings, comment} {}

}  // namespace tabetai2::core::schedule

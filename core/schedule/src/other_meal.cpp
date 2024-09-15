#include <schedule/other_meal.h>

#include <utility>

namespace tabetai2::core::schedule {

OtherMeal::OtherMeal(std::string title, unsigned servings, std::string comment) :
Meal{MealType::Other, std::move(title), servings, comment} {}

}  // namespace tabetai2::core::schedule

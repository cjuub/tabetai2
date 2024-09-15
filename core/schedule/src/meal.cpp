#include <schedule/meal.h>
#include <schedule/meal_type.h>

namespace tabetai2::core::schedule {

Meal::Meal(MealType type, std::string title, unsigned servings, std::string comment) :
m_type{type}, m_title{title}, m_servings{servings}, m_comment{comment} {}

MealType Meal::type() const {
    return m_type;
}

std::string Meal::title() const {
    return m_title;
}

unsigned Meal::servings() const {
    return m_servings;
}

std::string Meal::comment() const {
    return m_comment;
}

}  // namespace tabetai2::core::schedule

#include <schedule/meal.h>

#include <utility>

namespace tabetai2::core::schedule {

using namespace recipe;

Meal::Meal(Recipe recipe, unsigned servings, bool is_leftovers, std::string comment)
: m_recipe{std::move(recipe)}, m_servings{servings}, m_is_leftovers{is_leftovers}, m_comment{comment} {}


Recipe Meal::recipe() const {
    return m_recipe;
}

unsigned Meal::servings() const {
    return m_servings;
}

bool Meal::is_leftovers() const {
    return m_is_leftovers;
}

std::string Meal::comment() const {
    return m_comment;
}

}


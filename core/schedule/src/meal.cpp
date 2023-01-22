#include <schedule/meal.h>

#include <utility>

namespace tabetai2::core::schedule {

using namespace recipe;

Meal::Meal(Recipe recipe, unsigned servings)
: m_recipe{std::move(recipe)}, m_servings{servings} {}


Recipe Meal::recipe() const {
    return m_recipe;
}

unsigned Meal::servings() const {
    return m_servings;
}

}


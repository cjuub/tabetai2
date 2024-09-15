#pragma once

#include <recipe/recipe.h>

#include "schedule/meal.h"

namespace tabetai2::core::schedule {

class RecipeMeal : public Meal {
public:
    RecipeMeal(recipe::Recipe recipe, unsigned servings, std::string comment);

    recipe::Recipe recipe() const;

private:
    recipe::Recipe m_recipe;
};

}  // namespace tabetai2::core::schedule

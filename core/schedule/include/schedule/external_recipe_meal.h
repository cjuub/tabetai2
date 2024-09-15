#pragma once

#include <recipe/recipe.h>

#include "schedule/meal.h"

namespace tabetai2::core::schedule {

class ExternalRecipeMeal : public Meal {
public:
    ExternalRecipeMeal(std::string title, std::string url, unsigned servings, std::string comment);

    std::string url() const;

private:
    std::string m_url;
};

}  // namespace tabetai2::core::schedule

#pragma once

#include <schedule/meal.h>

#include "meal.h"

namespace tabetai2::core::schedule {

class OtherMeal : public Meal {
public:
    OtherMeal(std::string title, unsigned servings, std::string comment);
};

}  // namespace tabetai2::core::schedule

#pragma once

#include <string>

#include "schedule/meal_type.h"

namespace tabetai2::core::schedule {

class Meal {
public:
    Meal(MealType type, std::string title, unsigned servings, std::string comment);

    MealType type() const;

    std::string title() const;

    unsigned servings() const;

    std::string comment() const;

    virtual ~Meal() = default;

private:
    MealType m_type;
    std::string m_title;
    unsigned m_servings;
    std::string m_comment;
};

}  // namespace tabetai2::core::schedule

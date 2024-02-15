#pragma once

#include <optional>
#include <vector>

#include "ingredient/ingredient.h"
#include "recipe/quantity.h"
namespace tabetai2::core::schedule {

class ScheduleSummary {
public:
    ScheduleSummary(
        std::vector<std::pair<ingredient::Ingredient, std::vector<std::optional<recipe::Quantity>>>> ingredients);

    std::vector<std::pair<ingredient::Ingredient, std::vector<std::optional<recipe::Quantity>>>> ingredients() const;

private:
    std::vector<std::pair<ingredient::Ingredient, std::vector<std::optional<recipe::Quantity>>>> m_ingredients;
};

}  // namespace tabetai2::core::schedule

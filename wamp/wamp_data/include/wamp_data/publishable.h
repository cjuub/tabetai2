#pragma once

#include <variant>
#include <vector>
#include <string>

namespace tabetai2::wamp_data {

using IngredientData = std::tuple<
        std::string, // id, as string due to clients may not be able to handle uint64_t
        std::string>; // name

using RecipeData = std::tuple<
        std::string, // id, as string due to clients may not be able to handle uint64_t
        std::string, // name
        unsigned, // servings
        std::vector<std::pair<std::string, std::pair<unsigned, int>>>, // ingredients (id, (amount, unit))
        std::vector<std::string>>; // steps

using Publishable = std::variant<
        IngredientData, std::vector<IngredientData>,
        RecipeData, std::vector<RecipeData>>;
}

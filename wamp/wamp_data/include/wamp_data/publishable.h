#pragma once

#include <variant>
#include <vector>
#include <string>

namespace tabetai2::wamp_data {

using IngredientData = std::tuple<
        int, // id
        std::string>; // name

using RecipeData = std::tuple<
        int, // id
        std::string, // name
        unsigned, // servings
        std::vector<std::pair<int, std::pair<unsigned, int>>>, // ingredients (id, (amount, unit))
        std::vector<std::string>>; // steps

using Publishable = std::variant<
        IngredientData, std::vector<IngredientData>,
        RecipeData, std::vector<RecipeData>>;
}

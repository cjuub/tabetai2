#pragma once

#include <repository/repository.hpp>

#include "recipe.h"

#include <memory>
#include <optional>

namespace tabetai2::core::recipe {

class RecipeRepository : public repository::Repository<Recipe> {
public:
    using Repository<Recipe>::Repository;

    std::optional<Recipe> find_by_id(database::Id id) const;
    std::optional<Recipe> find_by_name(const std::string& name) const;
    std::optional<std::vector<Recipe>> find_by_ingredients(
            const std::vector<ingredient::Ingredient>& ingredients) const;
};

}

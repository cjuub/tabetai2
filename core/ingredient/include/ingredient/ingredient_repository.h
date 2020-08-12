#pragma once

#include <database/database.hpp>
#include <repository/repository.hpp>

#include "ingredient.h"

#include <memory>
#include <optional>

namespace tabetai2::core::ingredient {

class IngredientRepository : public repository::Repository<Ingredient> {
public:
    using Repository<Ingredient>::Repository;

    std::optional<Ingredient> find_by_id(int id) const;
    std::optional<Ingredient> find_by_name(const std::string& name) const;
};

}

#pragma once

#include <database/database.h>
#include <ingredient/ingredient.h>
#include <recipe/quantity.h>

#include <optional>
#include <string>
#include <vector>

namespace tabetai2::core::recipe {

class Recipe {
public:
    Recipe(database::Id id,
           std::string name,
           unsigned servings,
           std::vector<std::pair<ingredient::Ingredient, std::optional<Quantity>>> ingredients,
           std::vector<std::string> steps);

    database::Id id() const;

    std::string name() const;

    unsigned servings() const;

    std::vector<std::pair<ingredient::Ingredient, std::optional<Quantity>>> ingredients() const;

    std::vector<std::string> steps() const;

    bool operator<(const Recipe &r) const {
        return m_id < r.m_id;
    }

    bool operator==(const Recipe &) const = default;

private:
    database::Id m_id;
    std::string m_name;
    unsigned m_servings;
    std::vector<std::pair<ingredient::Ingredient, std::optional<Quantity>>> m_ingredients;
    std::vector<std::string> m_steps;
};

}  // namespace tabetai2::core::recipe

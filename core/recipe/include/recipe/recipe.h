#pragma once

#include <ingredient/ingredient.h>

#include <string>
#include <vector>

namespace tabetai2::core::recipe {

class Recipe {
public:
    Recipe(int id, std::string name, std::vector<ingredient::Ingredient> ingredients, std::vector<std::string> steps);

    int id() const;
    std::string name() const;
    std::vector<ingredient::Ingredient> ingredients() const;
    std::vector<std::string> steps() const;

    bool operator<(const Recipe &r) const {
        return m_id < r.m_id;
    }

    bool operator==(const Recipe &) const = default;

private:
    int m_id;
    std::string m_name;
    std::vector<ingredient::Ingredient> m_ingredients;
    std::vector<std::string> m_steps;
};

}

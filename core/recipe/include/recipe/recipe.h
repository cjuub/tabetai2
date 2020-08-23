#pragma once

#include <ingredient/ingredient.h>

#include <string>
#include <vector>

namespace tabetai2::core::recipe {

class Recipe {
public:
    Recipe(int id, std::string name, std::vector<ingredient::Ingredient> ingredients);

    int id() const;
    std::string name() const;
    std::vector<ingredient::Ingredient> ingredients();

private:
    const int m_id;
    std::string m_name;
    std::vector<ingredient::Ingredient> m_ingredients;
};

}

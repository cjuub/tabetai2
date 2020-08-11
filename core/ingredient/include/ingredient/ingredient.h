#pragma once

#include <string>

namespace tabetai2::core::ingredient {

class Ingredient {
public:
    Ingredient(int id, std::string name);
    Ingredient(const Ingredient& other);

    int id() const;
    std::string name() const;

private:
    const int m_id;
    const std::string m_name;
};

}

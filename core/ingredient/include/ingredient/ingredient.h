#pragma once

#include <string>

namespace tabetai2::core::ingredient {

class Ingredient {
public:
    Ingredient(int id, std::string name);

    int id() const;
    std::string name() const;

    bool operator<(const Ingredient &i) const {
        return m_id < i.m_id;
    }

    bool operator==(const Ingredient &) const = default;

private:
    int m_id;
    std::string m_name;
};

}

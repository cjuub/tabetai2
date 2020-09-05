#pragma once

#include <database/database.h>

#include <string>

namespace tabetai2::core::ingredient {

class Ingredient {
public:
    Ingredient(database::Id id, std::string name);

    database::Id id() const;
    std::string name() const;

    bool operator<(const Ingredient &i) const {
        return m_id < i.m_id;
    }

    bool operator==(const Ingredient &) const = default;

private:
    database::Id m_id;
    std::string m_name;
};

}

#pragma once

#include "unit.h"

#include <string>

namespace tabetai2::core::recipe {

class Quantity {
public:
    Quantity(unsigned amount, Unit unit, int exponent);

    unsigned amount() const;
    Unit unit() const;
    int exponent() const;

    bool operator==(const Quantity& q) const = default;

private:
    unsigned m_amount;
    Unit m_unit;
    int m_exponent;
};

}

#pragma once

#include <string>

#include "unit.h"

namespace tabetai2::core::recipe {

class Quantity {
public:
    Quantity(double amount, Unit unit);

    double amount() const;
    Unit unit() const;

    bool operator==(const Quantity& q) const = default;

private:
    double m_amount;
    Unit m_unit;
};

}  // namespace tabetai2::core::recipe

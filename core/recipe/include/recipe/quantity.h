#pragma once

#include "unit.h"

#include <string>

namespace tabetai2::core::recipe {

class Quantity {
public:
    Quantity(unsigned amount, Unit unit);

    unsigned amount() const;
    Unit unit() const;

    bool operator==(const Quantity& q) const = default;

private:
    unsigned m_amount;
    Unit m_unit;
};

}

#include "recipe/quantity.h"

namespace tabetai2::core::recipe {

Quantity::Quantity(unsigned amount, Unit unit, int exponent)
: m_amount{amount},
  m_unit{unit},
  m_exponent{exponent} {

}

unsigned Quantity::amount() const {
    return m_amount;
}

Unit Quantity::unit() const {
    return m_unit;
}

int Quantity::exponent() const {
    return m_exponent;
}

}

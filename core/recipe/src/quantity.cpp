#include "recipe/quantity.h"

namespace tabetai2::core::recipe {

Quantity::Quantity(unsigned int amount, Unit unit)
: m_amount(amount),
  m_unit(unit) {

}

unsigned Quantity::amount() const {
    return m_amount;
}

Unit Quantity::unit() const {
    return m_unit;
}

}

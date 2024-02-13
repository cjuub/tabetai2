#include "recipe/quantity.h"

namespace tabetai2::core::recipe {

Quantity::Quantity(double amount, Unit unit)
: m_amount{amount},
  m_unit{unit} {

}

double Quantity::amount() const {
    return m_amount;
}

Unit Quantity::unit() const {
    return m_unit;
}

}

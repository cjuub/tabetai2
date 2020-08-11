#include <ingredient/ingredient.h>

#include <utility>

namespace tabetai2::core::ingredient {

Ingredient::Ingredient(int id, std::string name)
: m_id(id),
  m_name(std::move(name)) {

}

Ingredient::Ingredient(const Ingredient& other)
: m_id(other.id()),
  m_name(other.name()) {

}

int Ingredient::id() const {
    return m_id;
}

std::string Ingredient::name() const {
    return m_name;
}


}

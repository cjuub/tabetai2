#include <ingredient/ingredient.h>

#include <utility>

namespace tabetai2::core::ingredient {

using namespace core::database;

Ingredient::Ingredient(Id id, std::string name)
: m_id{id},
  m_name{std::move(name)} {

}

Id Ingredient::id() const {
    return m_id;
}

std::string Ingredient::name() const {
    return m_name;
}


}

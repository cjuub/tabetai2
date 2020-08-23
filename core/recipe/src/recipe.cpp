#include <recipe/recipe.h>

#include <utility>

namespace tabetai2::core::recipe {

using namespace ingredient;

Recipe::Recipe(int id, std::string name, std::vector<Ingredient> ingredients)
: m_id(id),
  m_name(std::move(name)),
  m_ingredients(std::move(ingredients)) {
}

int Recipe::id() const {
    return m_id;
}

std::string Recipe::name() const {
    return m_name;
}

std::vector<ingredient::Ingredient> Recipe::ingredients() {
    return m_ingredients;
}

}

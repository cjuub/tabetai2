#include <ingredient/ingredient_repository.h>

#include <stdexcept>

namespace tabetai2::core::ingredient {

using namespace core::database;

std::optional<Ingredient> IngredientRepository::find_by_id(Id id) const try {
    return m_database->get(id);
} catch (const std::out_of_range &) {
    return std::nullopt;
}

std::optional<Ingredient> IngredientRepository::find_by_name(const std::string &name) const {
    auto ingredients = m_database->get_all();
    auto it = std::ranges::find_if(ingredients, [&](const auto &i) { return i.name() == name; });
    return it == ingredients.end() ? std::nullopt : std::make_optional(*it);
}

}  // namespace tabetai2::core::ingredient

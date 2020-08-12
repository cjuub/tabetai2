#include <ingredient/ingredient_repository.h>

namespace tabetai2::core::ingredient {

std::optional<Ingredient> IngredientRepository::find_by_id(int id) const {
    return m_database->get(id);
}

std::optional<Ingredient> IngredientRepository::find_by_name(const std::string& name) const {
    auto ingredients = m_database->get_all();

    for (auto& ingredient : ingredients) {
        if (ingredient.name() == name) {
            return ingredient;
        }
    }

    return {};
}

}

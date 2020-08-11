#include <ingredient/ingredient_repository.h>

namespace tabetai2::core::ingredient {

using namespace database;

IngredientRepository::IngredientRepository(std::unique_ptr<Database<Ingredient>> database)
: m_database(std::move(database)) {

}

void IngredientRepository::add(const Ingredient& ingredient) {
    m_database->add(ingredient);
}

void IngredientRepository::erase(const Ingredient& ingredient) {
    m_database->erase(ingredient);
}

std::optional<Ingredient> IngredientRepository::find_by_id(int id) {
    // TODO fix this shit
//    return m_database->get(id);
    return {};
}

std::optional<Ingredient> IngredientRepository::find_by_name(const std::string& name) {
    auto ingredients = m_database->get_all();

    for (auto& ingredient : ingredients) {
        if (ingredient.name() == name) {
            return ingredient;
        }
    }

    return {};
}

}

#include "recipe_repository_publisher.h"

#include <map>
#include <utility>
#include <vector>

namespace tabetai2::wamp_publisher {

using namespace core::ingredient;
using namespace core::repository;
using namespace core::recipe;
using namespace wamp_data;
using namespace wamp_session;

RecipeRepositoryPublisher::RecipeRepositoryPublisher(
        const std::shared_ptr<RecipeRepository>& repository,
        const std::shared_ptr<IngredientRepository>& ingredient_repository,
        WampSession& session)
: RepositoryPublisher<Recipe>{repository},
  m_repository{repository},
  m_session{session} {

    m_session.create_rpc("com.tabetai2.add_recipe", std::function([=, this](
            int id,
            std::string name,
            int servings,
            std::map<std::string, std::pair<int, int>> ingredients_data,
            std::vector<std::string> steps) {
        std::vector<std::pair<Ingredient, std::optional<Quantity>>> ingredients;
        for (const auto& entry : ingredients_data) {
            auto quantity = std::make_optional(
                    Quantity{static_cast<unsigned>(entry.second.first), static_cast<Unit>(entry.second.second)});
            ingredients.emplace_back(ingredient_repository->find_by_id(std::stoi(entry.first)).value(), quantity);
        }

        m_repository->add(Recipe(id, std::move(name), servings, ingredients, std::move(steps)));
    }));

    m_session.create_rpc("com.tabetai2.erase_recipe", std::function([&](int id) {
        m_repository->erase(id);
    }));
}

void RecipeRepositoryPublisher::publish() {
    std::vector<RecipeData> recipes;
    for (const auto& recipe : m_repository->find_all()) {
        std::vector<std::pair<int, std::pair<unsigned, int>>> ingredients;
        for (const auto& ingredient : recipe.ingredients()) {
            unsigned amount = 0;
            int unit = -1;
            if (ingredient.second) {
                amount = ingredient.second->amount();
                unit = static_cast<int>(ingredient.second->unit());
            }

            ingredients.emplace_back(ingredient.first.id(), std::make_pair(amount, unit));
        }

        recipes.emplace_back(recipe.id(), recipe.name(), recipe.servings(), std::move(ingredients), recipe.steps());
    }

    m_session.publish("com.tabetai2.recipes", recipes);
}

}

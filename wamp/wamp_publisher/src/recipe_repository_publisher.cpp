#include "recipe_repository_publisher.h"

namespace tabetai2::wamp_publisher {

using namespace core::repository;
using namespace core::recipe;
using namespace wamp_data;
using namespace wamp_session;

RecipeRepositoryPublisher::RecipeRepositoryPublisher(
        const std::shared_ptr<core::recipe::RecipeRepository>& repository,
        WampSession& session)
: RepositoryPublisher<Recipe>{repository},
  m_repository{repository},
  m_session{session} {

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

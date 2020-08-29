#include "recipe_repository_publisher.h"

namespace tabetai2::wamp_publisher {

using namespace core::repository;
using namespace core::recipe;
using namespace wamp_session;

RecipeRepositoryPublisher::RecipeRepositoryPublisher(
        const std::shared_ptr<core::recipe::RecipeRepository>& repository,
        WampSession& session)
: RepositoryPublisher<Recipe>{repository},
  m_repository{repository},
  m_session{session} {

}

void RecipeRepositoryPublisher::publish() {
    std::vector<std::string> recipes;
    for (const auto& recipe : m_repository->find_all()) {
        recipes.push_back(recipe.name());
    }

    m_session.publish("com.tabetai2.recipes", recipes);
}

}

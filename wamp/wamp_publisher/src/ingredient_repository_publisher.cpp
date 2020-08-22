#include "ingredient_repository_publisher.h"

namespace tabetai2::wamp_publisher {

using namespace core::repository;
using namespace core::ingredient;
using namespace wamp_session;

IngredientRepositoryPublisher::IngredientRepositoryPublisher(
        const std::shared_ptr<core::ingredient::IngredientRepository>& repository,
        WampSession& session)
: RepositoryPublisher<Ingredient>(repository),
  m_repository(repository),
  m_session(session) {

}

void IngredientRepositoryPublisher::publish() {
    std::vector<std::string> ingredients;
    for (const auto& ingredient : m_repository->find_all()) {
        ingredients.push_back(ingredient.name());
    }

    m_session.publish("com.tabetai2.ingredients", ingredients);
}

}

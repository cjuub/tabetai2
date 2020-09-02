#include "ingredient_repository_publisher.h"

#include <wamp_data/publishable.h>

namespace tabetai2::wamp_publisher {

using namespace core::repository;
using namespace core::ingredient;
using namespace wamp_data;
using namespace wamp_session;

IngredientRepositoryPublisher::IngredientRepositoryPublisher(
        const std::shared_ptr<core::ingredient::IngredientRepository>& repository,
        WampSession& session)
: RepositoryPublisher<Ingredient>{repository},
  m_repository{repository},
  m_session{session} {

    m_session.create_rpc("com.tabetai2.add_ingredient", std::function([&](int id, std::string name) {
        m_repository->add(Ingredient(id, std::move(name)));
    }));

    m_session.create_rpc("com.tabetai2.erase_ingredient", std::function([&](int id) {
        m_repository->erase(id);
    }));
}

void IngredientRepositoryPublisher::publish() {
    std::vector<IngredientData> ingredients;
    for (const auto& ingredient : m_repository->find_all()) {
        ingredients.emplace_back(ingredient.id(), ingredient.name());
    }

    m_session.publish("com.tabetai2.ingredients", ingredients);
}

}

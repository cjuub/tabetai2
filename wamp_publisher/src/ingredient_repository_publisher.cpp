#include "ingredient_repository_publisher.h"
#include "wamp_publisher/session.h"

#include <autobahn/autobahn.hpp>

#include <iostream>

namespace tabetai2::wamp_publisher {

using namespace core::repository;
using namespace core::ingredient;

IngredientRepositoryPublisher::IngredientRepositoryPublisher(
        const std::shared_ptr<core::ingredient::IngredientRepository>& repository,
        Session& session)
: RepositoryPublisher<Ingredient>(repository),
  m_repository(repository),
  m_session(session) {

}

void IngredientRepositoryPublisher::publish() {
    std::cout << "Publishing ingredient repository with wamp" << std::endl;

    std::vector<std::string> ingredients;
    for (const auto& ingredient : m_repository->find_all()) {
        ingredients.push_back(ingredient.name());
    }

    m_session.session()->publish("com.tabetai2.ingredients", ingredients);
}

}

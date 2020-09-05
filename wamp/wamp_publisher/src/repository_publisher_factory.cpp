#include "wamp_publisher/repository_publisher_factory.h"

#include "ingredient_repository_publisher.h"
#include "recipe_repository_publisher.h"

#include <utility>

namespace tabetai2::wamp_publisher {

using namespace core::data_publisher;
using namespace core::ingredient;
using namespace core::recipe;
using namespace core::database;
using namespace wamp_session;

RepositoryPublisherFactory::RepositoryPublisherFactory(
        WampSession& session,
        std::shared_ptr<IdGenerator> id_generator)
: m_session{session},
  m_id_generator(std::move(id_generator)) {

}

std::shared_ptr<Publisher> RepositoryPublisherFactory::create_ingredient_repository_publisher(
        std::shared_ptr<IngredientRepository> ingredient_repository) {
    return std::make_shared<IngredientRepositoryPublisher>(
            ingredient_repository, m_session, m_id_generator);
}

std::shared_ptr<Publisher> RepositoryPublisherFactory::create_recipe_repository_publisher(
        std::shared_ptr<RecipeRepository> recipe_repository,
        std::shared_ptr<IngredientRepository> ingredient_repository) {
    return std::make_shared<RecipeRepositoryPublisher>(
            recipe_repository, ingredient_repository, m_session, m_id_generator);
}

}

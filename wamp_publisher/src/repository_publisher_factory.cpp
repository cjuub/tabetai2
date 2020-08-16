#include "wamp_publisher/repository_publisher_factory.h"

#include "ingredient_repository_publisher.h"

#include <ingredient/ingredient_repository.h>

namespace tabetai2::wamp_publisher {

using namespace core::data_publisher;
using namespace core::ingredient;

std::shared_ptr<Publisher> RepositoryPublisherFactory::create_ingredient_repository_publisher(
        std::shared_ptr<IngredientRepository> ingredient_repository) {
    return std::make_shared<IngredientRepositoryPublisher>(ingredient_repository);
}

}

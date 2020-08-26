#include "server/server_factory.h"

#include "impl/server.h"

#include <data_publisher/publisher.h>
#include <data_publisher/repository_publisher_factory.h>
#include <yaml_database/yaml_ingredient_database.h>

namespace tabetai2::core::server {

using namespace core::database;
using namespace core::data_publisher;
using namespace core::ingredient;
using namespace core::recipe;
using namespace core::repository;
using namespace core::util;
using namespace yaml_database;

ServerFactory::ServerFactory(std::unique_ptr<RepositoryPublisherFactory> repository_publisher_factory)
: m_repository_publisher_factory(std::move(repository_publisher_factory)) {

}

std::unique_ptr<Server> ServerFactory::create() const {
    auto ingredient_database = std::make_unique<YamlIngredientDatabase>("database.yaml");
    auto ingredient_repository = std::make_shared<IngredientRepository>(std::move(ingredient_database));

    auto recipe_database = std::make_unique<InMemoryDatabase<Recipe>>();
    auto recipe_repository = std::make_shared<RecipeRepository>(std::move(recipe_database));

    std::vector<std::shared_ptr<Publisher>> publishers;
    publishers.push_back(m_repository_publisher_factory->create_ingredient_repository_publisher(ingredient_repository));
    publishers.push_back(m_repository_publisher_factory->create_recipe_repository_publisher(recipe_repository));

    return std::make_unique<impl::Server>(ingredient_repository, recipe_repository, publishers);
}


}

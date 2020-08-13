#include "server/server_factory.h"

#include <repository/repository_publisher.hpp>

#include "impl/server.h"

namespace tabetai2::core::server {

using namespace core::database;
using namespace core::ingredient;
using namespace core::repository;
using namespace core::server;
using namespace core::util;

std::unique_ptr<Server> ServerFactory::create() const {
    auto ingredient_database = std::make_unique<Database<Ingredient>>();
    auto ingredient_repository = std::make_shared<IngredientRepository>(std::move(ingredient_database));

    std::vector<std::shared_ptr<Publisher>> publishers;
    publishers.push_back(std::make_shared<RepositoryPublisher<Ingredient>>(ingredient_repository));

    return std::make_unique<impl::Server>(ingredient_repository, publishers);
}

}

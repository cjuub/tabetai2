#include "server_factory.h"

#include <server/server.h>

namespace tabetai2::application {

using namespace core::database;
using namespace core::ingredient;
using namespace core::server;

std::unique_ptr<Server> ServerFactory::create() const {
    auto ingredient_database = std::make_unique<Database<Ingredient>>();
    auto ingredient_repository = std::make_unique<IngredientRepository>(std::move(ingredient_database));

    return std::make_unique<impl::Server>(std::move(ingredient_repository));
}

}

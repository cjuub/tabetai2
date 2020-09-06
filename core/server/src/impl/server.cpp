#include "impl/server.h"

#include <iostream>
#include <utility>

namespace tabetai2::core::server::impl {

using namespace core::data_publisher;
using namespace core::ingredient;
using namespace core::recipe;

Server::Server(std::shared_ptr<IngredientRepository> ingredient_repository,
               std::shared_ptr<RecipeRepository> recipe_repository,
               std::vector<std::shared_ptr<Publisher>> publishers)
: m_ingredient_repository{std::move(ingredient_repository)},
  m_recipe_repository{std::move(recipe_repository)},
  m_publishers{std::move(publishers)} {

}

void Server::run() {
    std::cout << "Server started" << std::endl;

    for (auto& publisher : m_publishers) {
        publisher->publish();
    }
}

}

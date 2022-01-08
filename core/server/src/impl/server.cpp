#include "impl/server.h"

#include <ingredient/ingredient.h>
#include <recipe/recipe.h>

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
    auto ing = Ingredient(0, "fisk");
    auto ing2 = Ingredient(1, "disp");
    m_ingredient_repository->add(ing);
    m_ingredient_repository->add(ing2);
    m_recipe_repository->add(Recipe(0, "recept", 4, {std::make_pair(ing, Quantity(2, Unit::DL))}, {"disp"}));
    std::cout << "Server started" << std::endl;

    for (auto& publisher : m_publishers) {
        publisher->publish();
    }
}

}

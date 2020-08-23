#include "impl/server.h"

#include <iostream>
#include <utility>

namespace tabetai2::core::server::impl {

using namespace data_publisher;
using namespace ingredient;
using namespace recipe;

Server::Server(std::shared_ptr<IngredientRepository> ingredient_repository,
               std::shared_ptr<RecipeRepository> recipe_repository,
               std::vector<std::shared_ptr<Publisher>> publishers)
: m_ingredient_repository(std::move(ingredient_repository)),
  m_recipe_repository(std::move(recipe_repository)),
  m_publishers(std::move(publishers)) {

}

void Server::run() {
    std::cout << "This is Tabetai2 server" << std::endl;

    auto fisk = Ingredient(0, "fisk");
    auto potatis = Ingredient(1, "potatis");
    m_ingredient_repository->add(fisk);
    m_ingredient_repository->add(potatis);
    std::cout << m_ingredient_repository->find_by_id(0)->name() << std::endl;
    std::cout << m_ingredient_repository->find_by_name("potatis")->id() << std::endl;

    m_recipe_repository->add(Recipe(0, "fisk med potatis", {fisk, potatis}));
    m_recipe_repository->add(Recipe(1, "fisk", {fisk}));
    std::cout << m_recipe_repository->find_by_id(0)->name() << std::endl;
    std::cout << m_recipe_repository->find_by_name("fisk med potatis")->id() << std::endl;
    std::cout << m_recipe_repository->find_by_ingredients({fisk})->size() << std::endl;
}

}


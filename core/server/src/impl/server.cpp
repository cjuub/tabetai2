#include "impl/server.h"

#include <communicator/communicator.h>
#include <ingredient/ingredient.h>
#include <recipe/recipe.h>

#include <iostream>
#include <utility>

namespace tabetai2::core::server::impl {

using namespace core::communicator;
using namespace core::data_publisher;
using namespace core::ingredient;
using namespace core::recipe;
using namespace core::schedule;

Server::Server(std::unique_ptr<Communicator> communicator,
               std::shared_ptr<IngredientRepository> ingredient_repository,
               std::shared_ptr<RecipeRepository> recipe_repository,
               std::shared_ptr<ScheduleRepository> schedule_repository) :
m_communicator{std::move(communicator)},
m_ingredient_repository{std::move(ingredient_repository)},
m_recipe_repository{std::move(recipe_repository)},
m_schedule_repository{std::move(schedule_repository)} {}

void Server::run() {
    std::cout << "Starting communicator" << std::endl;
    m_communicator->run();
}

}  // namespace tabetai2::core::server::impl

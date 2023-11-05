#include <application_server/server_factory.h>

#include <database/id_generator_factory.h>
#include <grpc_communicator/grpc_communicator.h>
#include <yaml_database/yaml_ingredient_database.h>
#include <yaml_database/yaml_recipe_database.h>
#include <yaml_database/yaml_schedule_database.h>

#include <impl/server.h>

#include <memory>

namespace tabetai2::application_server {

using namespace core::database;
using namespace core::data_publisher;
using namespace core::ingredient;
using namespace core::recipe;
using namespace core::repository;
using namespace core::schedule;
using namespace core::server;
using namespace core::util;
using namespace grpc_communicator;
using namespace yaml_database;


std::unique_ptr<Server> ServerFactory::create() const {
    auto id_generator = IdGeneratorFactory::create();

    auto ingredient_database = std::make_unique<YamlIngredientDatabase>("db_ingredient.yaml", "ingredients");
    auto ingredient_repository = std::make_shared<IngredientRepository>(std::move(ingredient_database));

    auto recipe_database = std::make_unique<YamlRecipeDatabase>("db_recipe.yaml", "recipes", ingredient_repository);
    auto recipe_repository = std::make_shared<RecipeRepository>(std::move(recipe_database));

    auto schedule_database = std::make_unique<YamlScheduleDatabase>("db_schedule.yaml", "schedules", recipe_repository);
    auto schedule_repository = std::make_shared<ScheduleRepository>(std::move(schedule_database));

    auto communicator = std::make_unique<GrpcCommunicator>(ingredient_repository, recipe_repository, schedule_repository, id_generator);

    return std::make_unique<core::server::impl::Server>(std::move(communicator), ingredient_repository, recipe_repository, schedule_repository);
}

}

#pragma once

#include "server/server.h"

#include <communicator/communicator.h>
#include <data_publisher/publisher.h>
#include <ingredient/ingredient_repository.h>
#include <recipe/recipe_repository.h>
#include <schedule/schedule_repository.h>

#include <memory>

namespace tabetai2::core::server::impl {

class Server : public server::Server {
public:
    explicit Server(std::unique_ptr<communicator::Communicator> communicator,
                    std::shared_ptr<ingredient::IngredientRepository> ingredient_repository,
                    std::shared_ptr<recipe::RecipeRepository> recipe_repository,
                    std::shared_ptr<schedule::ScheduleRepository> schedule_repository);
    void run() override;

private:
    std::unique_ptr<communicator::Communicator> m_communicator;
    std::shared_ptr<ingredient::IngredientRepository> m_ingredient_repository;
    std::shared_ptr<recipe::RecipeRepository> m_recipe_repository;
    std::shared_ptr<schedule::ScheduleRepository> m_schedule_repository;
};

}

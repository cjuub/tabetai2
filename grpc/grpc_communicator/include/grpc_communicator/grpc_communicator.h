#pragma once

#include <communicator/communicator.h>
#include <database/id_generator.h>
#include <ingredient/ingredient_repository.h>
#include <recipe/recipe_repository.h>
#include <schedule/schedule_repository.h>

namespace tabetai2::grpc_communicator {

class GrpcCommunicator : public core::communicator::Communicator {
public:
    explicit GrpcCommunicator(std::shared_ptr<core::ingredient::IngredientRepository> ingredient_repository,
                              std::shared_ptr<core::recipe::RecipeRepository> recipe_repository,
                              std::shared_ptr<core::schedule::ScheduleRepository> schedule_repository,
                              std::shared_ptr<core::database::IdGenerator> id_generator);
    void run() override;

private:
    std::shared_ptr<core::ingredient::IngredientRepository> m_ingredient_repository;
    std::shared_ptr<core::recipe::RecipeRepository> m_recipe_repository;
    std::shared_ptr<core::schedule::ScheduleRepository> m_schedule_repository;
    std::shared_ptr<core::database::IdGenerator> m_id_generator;
};

}

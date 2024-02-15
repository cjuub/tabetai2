#pragma once

#include <ingredient/ingredient_repository.h>
#include <recipe/recipe_repository.h>
#include <schedule/schedule_repository.h>

#include <memory>

#include "publisher.h"

namespace tabetai2::core::data_publisher {

class RepositoryPublisherFactory {
public:
    virtual std::shared_ptr<Publisher> create_ingredient_repository_publisher(
        std::shared_ptr<ingredient::IngredientRepository> ingredient_repository) = 0;

    virtual std::shared_ptr<Publisher> create_recipe_repository_publisher(
        std::shared_ptr<recipe::RecipeRepository> recipe_repository,
        std::shared_ptr<ingredient::IngredientRepository> ingredient_repository) = 0;

    virtual std::shared_ptr<Publisher> create_schedule_repository_publisher(
        std::shared_ptr<schedule::ScheduleRepository> schedule_repository,
        std::shared_ptr<recipe::RecipeRepository> recipe_repository) = 0;

    virtual ~RepositoryPublisherFactory() = default;
};

}  // namespace tabetai2::core::data_publisher

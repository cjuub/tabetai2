#pragma once

#include "server/server.h"

#include <data_publisher/publisher.h>
#include <ingredient/ingredient_repository.h>
#include <recipe/recipe_repository.h>

#include <memory>

namespace tabetai2::core::server::impl {

class Server : public server::Server {
public:
    explicit Server(std::shared_ptr<ingredient::IngredientRepository> ingredient_repository,
                    std::shared_ptr<recipe::RecipeRepository> recipe_repository,
                    std::vector<std::shared_ptr<data_publisher::Publisher>> publishers);
    void run() override;

private:
    std::shared_ptr<ingredient::IngredientRepository> m_ingredient_repository;
    std::shared_ptr<recipe::RecipeRepository> m_recipe_repository;
    std::vector<std::shared_ptr<data_publisher::Publisher>> m_publishers;
};

}

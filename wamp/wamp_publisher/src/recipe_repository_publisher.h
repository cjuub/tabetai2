#pragma once

#include <database/id_generator.h>
#include <data_publisher/repository_publisher.hpp>
#include <ingredient/ingredient_repository.h>
#include <recipe/recipe.h>
#include <recipe/recipe_repository.h>
#include <wamp_session/wamp_session.h>

namespace tabetai2::wamp_publisher {

class RecipeRepositoryPublisher : public core::data_publisher::RepositoryPublisher<core::recipe::Recipe> {
public:
    explicit RecipeRepositoryPublisher(const std::shared_ptr<core::recipe::RecipeRepository>& repository,
                                       const std::shared_ptr<core::ingredient::IngredientRepository>& ingredient_repository,
                                       wamp_session::WampSession& session,
                                       std::shared_ptr<core::database::IdGenerator> id_generator);

    void publish() override;

private:
    std::shared_ptr<core::recipe::RecipeRepository> m_repository;
    wamp_session::WampSession& m_session;
};

}

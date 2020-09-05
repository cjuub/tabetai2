#pragma once

#include <data_publisher/repository_publisher_factory.h>
#include <ingredient/ingredient_repository.h>
#include <database/id_generator.h>
#include <wamp_session/wamp_session.h>

namespace tabetai2::wamp_publisher {

class RepositoryPublisherFactory : public core::data_publisher::RepositoryPublisherFactory {
public:
    explicit RepositoryPublisherFactory(
            wamp_session::WampSession& session,
            std::shared_ptr<core::database::IdGenerator> id_generator);

    std::shared_ptr<core::data_publisher::Publisher> create_ingredient_repository_publisher(
            std::shared_ptr<core::ingredient::IngredientRepository> ingredient_repository) override;

    std::shared_ptr<core::data_publisher::Publisher> create_recipe_repository_publisher(
            std::shared_ptr<core::recipe::RecipeRepository> recipe_repository,
            std::shared_ptr<core::ingredient::IngredientRepository> ingredient_repository) override;
private:
    wamp_session::WampSession& m_session;
    std::shared_ptr<core::database::IdGenerator> m_id_generator;
};

}

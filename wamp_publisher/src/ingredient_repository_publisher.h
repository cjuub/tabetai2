#pragma once

#include <data_publisher/repository_publisher.hpp>
#include <ingredient/ingredient.h>
#include <ingredient/ingredient_repository.h>
#include <wamp_publisher/session.h>

namespace tabetai2::wamp_publisher {

class IngredientRepositoryPublisher : public core::data_publisher::RepositoryPublisher<core::ingredient::Ingredient> {
public:
    explicit IngredientRepositoryPublisher(const std::shared_ptr<core::ingredient::IngredientRepository>& repository,
                                           Session& session);

    void publish() override;

private:
    std::shared_ptr<core::ingredient::IngredientRepository> m_repository;
    Session& m_session;
};

}

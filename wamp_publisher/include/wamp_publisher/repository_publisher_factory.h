#pragma once

#include <data_publisher/repository_publisher_factory.h>
#include <ingredient/ingredient_repository.h>
#include "session.h"

namespace tabetai2::wamp_publisher {

class RepositoryPublisherFactory : public core::data_publisher::RepositoryPublisherFactory {
public:
    explicit RepositoryPublisherFactory(Session& session);
    std::shared_ptr<core::data_publisher::Publisher> create_ingredient_repository_publisher(
            std::shared_ptr<core::ingredient::IngredientRepository> ingredient_repository) override;

private:
    Session& m_session;

};

}
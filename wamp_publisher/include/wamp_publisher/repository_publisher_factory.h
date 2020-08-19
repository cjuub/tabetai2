#pragma once

#include "wamp_session.h"

#include <data_publisher/repository_publisher_factory.h>
#include <ingredient/ingredient_repository.h>

namespace tabetai2::wamp_publisher {

class RepositoryPublisherFactory : public core::data_publisher::RepositoryPublisherFactory {
public:
    explicit RepositoryPublisherFactory(WampSession& session);
    std::shared_ptr<core::data_publisher::Publisher> create_ingredient_repository_publisher(
            std::shared_ptr<core::ingredient::IngredientRepository> ingredient_repository) override;

private:
    WampSession& m_session;
};

}

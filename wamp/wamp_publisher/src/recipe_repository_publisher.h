#pragma once

#include <data_publisher/repository_publisher.hpp>
#include <recipe/recipe.h>
#include <recipe/recipe_repository.h>
#include <wamp_session/wamp_session.h>

namespace tabetai2::wamp_publisher {

class RecipeRepositoryPublisher : public core::data_publisher::RepositoryPublisher<core::recipe::Recipe> {
public:
    explicit RecipeRepositoryPublisher(const std::shared_ptr<core::recipe::RecipeRepository>& repository,
                                           wamp_session::WampSession& session);

    void publish() override;

private:
    std::shared_ptr<core::recipe::RecipeRepository> m_repository;
    wamp_session::WampSession& m_session;
};

}

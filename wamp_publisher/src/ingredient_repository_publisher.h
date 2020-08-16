#pragma once

#include <data_publisher/repository_publisher.hpp>
#include <ingredient/ingredient.h>

namespace tabetai2::wamp_publisher {

class IngredientRepositoryPublisher : public core::data_publisher::RepositoryPublisher<core::ingredient::Ingredient> {
public:
    using core::data_publisher::RepositoryPublisher<core::ingredient::Ingredient>::RepositoryPublisher;

    void publish() override;
};

}

#pragma once

#include "publisher.h"

#include <ingredient/ingredient_repository.h>

#include <memory>

namespace tabetai2::core::data_publisher {

class RepositoryPublisherFactory {
public:
    virtual std::shared_ptr<Publisher> create_ingredient_repository_publisher(
            std::shared_ptr<ingredient::IngredientRepository> ingredient_repository) = 0;

    virtual ~RepositoryPublisherFactory() = default;
};

}

#pragma once

#include "server/server.h"

#include <ingredient/ingredient_repository.h>
#include <util/publisher.h>

#include <memory>

namespace tabetai2::core::server::impl {

class Server : public server::Server {
public:
    explicit Server(std::shared_ptr<ingredient::IngredientRepository> ingredient_repository,
                    std::vector<std::shared_ptr<util::Publisher>> publishers);
    void run() override;

private:
    std::shared_ptr<ingredient::IngredientRepository> m_ingredient_repository;
    std::vector<std::shared_ptr<util::Publisher>> m_publishers;
};

}

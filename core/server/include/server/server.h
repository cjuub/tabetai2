#pragma once

#include <ingredient/ingredient_repository.h>

#include <memory>

namespace tabetai2::core::server {

class Server {
public:
    virtual ~Server() = default;
    virtual void run() = 0;
};

namespace impl {

class Server : public server::Server {
public:
    explicit Server(std::unique_ptr<ingredient::IngredientRepository> ingredient_repository);
    void run() override;

private:
    std::unique_ptr<ingredient::IngredientRepository> m_ingredient_repository;
};

}
}

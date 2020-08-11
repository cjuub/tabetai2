#include <server/server.h>

#include <iostream>

namespace tabetai2::core::server::impl {

using namespace ingredient;

Server::Server(std::unique_ptr<IngredientRepository> ingredient_repository)
: m_ingredient_repository(std::move(ingredient_repository)) {

}

void Server::run() {
    std::cout << "This is Tabetai2 server" << std::endl;
    m_ingredient_repository->add(Ingredient(0, "fisk"));
    m_ingredient_repository->add(Ingredient(1, "potatis"));
    std::cout << m_ingredient_repository->find_by_id(0)->name() << std::endl;
    std::cout << m_ingredient_repository->find_by_name("potatis")->id() << std::endl;
}

}


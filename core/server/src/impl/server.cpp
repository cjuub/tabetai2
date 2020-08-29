#include "impl/server.h"

#include <iostream>
#include <utility>

namespace tabetai2::core::server::impl {

using namespace data_publisher;
using namespace ingredient;
using namespace recipe;

Server::Server(std::shared_ptr<IngredientRepository> ingredient_repository,
               std::shared_ptr<RecipeRepository> recipe_repository,
               std::vector<std::shared_ptr<Publisher>> publishers)
: m_ingredient_repository{std::move(ingredient_repository)},
  m_recipe_repository{std::move(recipe_repository)},
  m_publishers{std::move(publishers)} {

}

void Server::run() {
    std::cout << "This is Tabetai2 server" << std::endl;

    auto fisk = Ingredient{0, "fisk"};
    auto potatis = Ingredient{1, "potatis"};
    m_ingredient_repository->add(fisk);
    m_ingredient_repository->add(potatis);
    std::cout << m_ingredient_repository->find_by_id(0)->name() << std::endl;
    std::cout << m_ingredient_repository->find_by_name("potatis")->id() << std::endl;

    auto fisk_med_potatis = Recipe{
            0,
            "fisk med potatis",
            100,
            {{fisk, Quantity{100, Unit::KG}},
             {potatis, Quantity{5, Unit::KRM}}},
            {"koka fisken", "koka potatisen"}};
    m_recipe_repository->add(fisk_med_potatis);

    auto stekt_fisk = Recipe{
            1,
            "stekt fisk",
            5,
            {{fisk, Quantity{5, Unit::PCS}}},
            {"stek fisken"}};
    m_recipe_repository->add(stekt_fisk);

    std::cout << m_recipe_repository->find_by_id(0)->name() << std::endl;
    std::cout << m_recipe_repository->find_by_name("fisk med potatis")->id() << std::endl;
    std::cout << m_recipe_repository->find_by_ingredients({fisk})->size() << std::endl;
    std::cout << m_recipe_repository->find_by_id(0)->ingredients()[0].first.name() << std::endl;
}

}


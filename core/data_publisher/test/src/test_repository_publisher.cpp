#include "data_publisher/repository_publisher.hpp"

#include "database/in_memory_database.hpp"
#include "ingredient/ingredient_repository.h"

#include <catch2/catch.hpp>

using namespace tabetai2::core::data_publisher;
using namespace tabetai2::core::database;
using namespace tabetai2::core::ingredient;

namespace {

struct TestRepoPublisher : RepositoryPublisher<Ingredient> {
    using RepositoryPublisher<Ingredient>::RepositoryPublisher;
    void publish() override {}
};

TEST_CASE("RepositoryPublisher") {
    auto repository = std::make_shared<IngredientRepository>(std::make_unique<InMemoryDatabase<Ingredient>>());

    SECTION("Cleans up after itself") {
        (void)TestRepoPublisher(repository);
        repository->add({0, "fish"});
    }
}

}

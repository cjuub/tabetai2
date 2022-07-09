#include "recipe/recipe_repository.h"

#include "database/in_memory_database.hpp"
#include "ingredient/ingredient.h"

#include <catch2/catch.hpp>

using namespace tabetai2::core::database;
using namespace tabetai2::core::ingredient;
using namespace tabetai2::core::recipe;

namespace {

TEST_CASE("RecipeRepository") {
    auto r = RecipeRepository{std::make_unique<InMemoryDatabase<Recipe>>()};
    const auto fish = Ingredient{0, "fish"};
    const auto potato = Ingredient{2, "fish"};
    const auto hedgehog = Ingredient{5, "fish"};
    const auto water = Ingredient{42, "water"};
    const auto boiled_fish = Recipe{
        13,
        "boiled fish",
        1,
        {{fish, Quantity{1, Unit::PCS, 0}},
         {water, Quantity{5, Unit::DL, 0}}},
        {"boil"}};
    const auto boiled_potato = Recipe{
        14,
        "boiled potato",
        2,
        {{potato, Quantity{2, Unit::PCS, 0}},
         {water, Quantity{4, Unit::L, 0}}},
        {"boil"}};
    const auto boiled_hedgehog = Recipe{
        17,
        "boiled hedgehog",
        1,
        {{hedgehog, Quantity{1, Unit::PCS, 0}},
         {water, Quantity{4, Unit::L, 0}}},
        {"boil"}};
    const auto hedgehog_with_potato = Recipe{
        15,
        "hedgehog with potato",
        2,
        {{hedgehog, Quantity{1, Unit::PCS, 0}},
         {potato, Quantity{1, Unit::PCS, 0}}},
        {"feed potato to hedgehog"}};
    r.add(boiled_fish);
    r.add(boiled_potato);
    r.add(boiled_hedgehog);
    r.add(hedgehog_with_potato);

    SECTION("add") {
        auto potato_with_potato = Recipe{
            19,
            "potato_with_potato",
            2,
            {{potato, Quantity{1, Unit::PCS, 0}},
             {potato, Quantity{1, Unit::PCS, 0}}},
            {"stack potatoes"}};
        REQUIRE(r.find_by_id(19).has_value() == false);
        auto count = r.find_all().size();
        r.add(potato_with_potato);
        REQUIRE(r.find_all().size() == count + 1);
        REQUIRE(r.find_by_id(19).has_value());
    }

    SECTION("find_by_id") {
        REQUIRE(r.find_by_id(14) == boiled_potato);
        REQUIRE(r.find_by_id(15) == hedgehog_with_potato);
    }

    SECTION("find_by_ingredients") {
        auto result = r.find_by_ingredients({water, fish, potato}).value();
        std::sort(result.begin(), result.end());
        REQUIRE(result == std::vector{boiled_fish, boiled_potato});

        result = r.find_by_ingredients({hedgehog, water, potato}).value();
        std::sort(result.begin(), result.end());
        REQUIRE(result == std::vector{boiled_potato, hedgehog_with_potato, boiled_hedgehog});
    }

    SECTION("find_by_name") {
        REQUIRE(r.find_by_name("boiled fish") == boiled_fish);
    }

    SECTION("find_all") {
        auto result = r.find_all();
        std::sort(result.begin(), result.end());
        REQUIRE(result == std::vector{boiled_fish, boiled_potato, hedgehog_with_potato, boiled_hedgehog});
    }

    SECTION("erase") {
        REQUIRE(r.find_by_id(14).has_value());
        r.erase(14);
        REQUIRE(r.find_by_id(14).has_value() == false);
    }
}

}

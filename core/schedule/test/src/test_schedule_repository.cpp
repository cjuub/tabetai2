#include <ingredient/ingredient.h>
#include <recipe/recipe_repository.h>
#include "schedule/schedule.h"
#include "schedule/schedule_repository.h"

#include "database/in_memory_database.hpp"

#include <catch2/catch.hpp>

using namespace tabetai2::core::database;
using namespace tabetai2::core::ingredient;
using namespace tabetai2::core::recipe;
using namespace tabetai2::core::schedule;

namespace {

TEST_CASE("ScheduleRepository") {
    auto recipe_repository = RecipeRepository{std::make_unique<InMemoryDatabase<Recipe>>()};
    const auto fish = Ingredient{0, "fish"};
    const auto potato = Ingredient{2, "fish"};
    const auto hedgehog = Ingredient{5, "fish"};
    const auto water = Ingredient{42, "water"};
    const auto boiled_fish = Recipe{
            13,
            "boiled fish",
            1,
            {{fish, Quantity{1, Unit::PCS}},
             {water, Quantity{5, Unit::DL}}},
            {"boil"}};
    recipe_repository.add(boiled_fish);

    const auto meal1 = Meal{boiled_fish, 2, false, ""};
    const auto meal2 = Meal{boiled_fish, 4, false, ""};
    const auto meal3 = Meal{boiled_fish, 6, false, ""};

    auto week1 = Schedule{23, "1970-01-01"};
    auto week1_day1 = ScheduleDay{};
    week1_day1.add_meal(meal1);
    week1.add_day(week1_day1);

    auto week2 = Schedule{455, "1970-01-01"};
    auto week2_day1 = ScheduleDay{};
    week2_day1.add_meal(meal1);
    week2.add_day(week2_day1);

    auto schedule_repository = ScheduleRepository{std::make_unique<InMemoryDatabase<Schedule>>()};
    schedule_repository.add(week1);
    schedule_repository.add(week2);

    SECTION("add") {
        REQUIRE(schedule_repository.find_by_id(2645).has_value() == false);
        auto count = schedule_repository.find_all().size();
        auto new_week = Schedule{2645, "1970-01-01"};
        schedule_repository.add(new_week);
        REQUIRE(schedule_repository.find_all().size() == count + 1);
        REQUIRE(schedule_repository.find_by_id(2645).has_value());
    }

    SECTION("find_by_id") {
        REQUIRE(schedule_repository.find_by_id(23) == week1);
        REQUIRE(schedule_repository.find_by_id(455) == week2);
    }

    SECTION("find_all") {
        auto result = schedule_repository.find_all();
        std::sort(result.begin(), result.end());
        REQUIRE(result == std::vector{week1, week2});
    }

    SECTION("erase") {
        REQUIRE(schedule_repository.find_by_id(455).has_value());
        schedule_repository.erase(455);
        REQUIRE(schedule_repository.find_by_id(455).has_value() == false);
    }
}

}

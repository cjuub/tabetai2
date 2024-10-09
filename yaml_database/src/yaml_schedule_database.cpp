#include <schedule/external_recipe_meal.h>
#include <schedule/recipe_meal.h>
#include <yaml_database/yaml_schedule_database.h>

#include <iostream>
#include <memory>
#include <string>

#include "schedule/leftovers_meal.h"
#include "schedule/other_meal.h"

namespace tabetai2::yaml_database {

using namespace core::database;
using namespace core::recipe;
using namespace core::schedule;

YamlScheduleDatabase::YamlScheduleDatabase(std::string database_file,
                                           std::string database_name,
                                           std::shared_ptr<RecipeRepository> recipe_repository) :
YamlDatabase<Schedule>{std::move(database_file), std::move(database_name)},
m_recipe_repository{std::move(recipe_repository)} {}

Schedule YamlScheduleDatabase::from_yaml(YAML::Node entry) const {
    Schedule schedule{entry["id"].as<Id>(), entry["start_date"].as<std::string>()};
    for (const auto &day_entry : entry["days"]) {
        ScheduleDay day;
        for (const auto &meal_entry : day_entry) {
            auto type = static_cast<MealType>(meal_entry["type"].as<int>());
            auto title = meal_entry["title"].as<std::string>();
            auto servings = meal_entry["servings"].as<unsigned>();
            auto comment = meal_entry["comment"].as<std::string>();

            switch (type) {
                case MealType::Recipe: {
                    auto recipe = m_recipe_repository->find_by_id(meal_entry["recipe"].as<Id>());
                    if (!recipe) {
                        std::cout << "Non-existing recipe referenced in schedule." << std::endl;
                    }
                    day.add_meal(std::make_unique<RecipeMeal>(recipe.value(), servings, comment));
                    break;
                }
                case MealType::ExternalRecipe:
                    day.add_meal(std::make_unique<ExternalRecipeMeal>(
                        title, meal_entry["url"].as<std::string>(), servings, comment));
                    break;
                case MealType::Leftovers:
                    day.add_meal(std::make_unique<LeftoversMeal>(title, servings, comment));
                    break;
                case MealType::Other:
                    day.add_meal(std::make_unique<OtherMeal>(title, servings, comment));
                    break;
            }
        }

        schedule.add_day(std::move(day));
    }

    return schedule;
}

YAML::Node YamlScheduleDatabase::to_yaml(const Schedule &schedule) const {
    YAML::Node entry;
    entry["id"] = schedule.id();
    entry["start_date"] = schedule.start_date();

    size_t day_index = 0;
    for (const auto &day : schedule.days()) {
        size_t meal_index = 0;
        for (const auto &meal : day.meals()) {
            entry["days"][day_index][meal_index]["type"] = static_cast<unsigned>(meal->type());
            entry["days"][day_index][meal_index]["title"] = meal->title();
            entry["days"][day_index][meal_index]["servings"] = meal->servings();
            entry["days"][day_index][meal_index]["comment"] = meal->comment();

            switch (meal->type()) {
                case MealType::Recipe:
                    entry["days"][day_index][meal_index]["recipe"] = dynamic_cast<RecipeMeal &>(*meal).recipe().id();
                    break;
                case MealType::ExternalRecipe:
                    entry["days"][day_index][meal_index]["url"] = dynamic_cast<ExternalRecipeMeal &>(*meal).url();
                    break;
                case MealType::Leftovers:
                case MealType::Other:
                    break;
            }
            ++meal_index;
        }

        ++day_index;
    }

    return entry;
}

}  // namespace tabetai2::yaml_database

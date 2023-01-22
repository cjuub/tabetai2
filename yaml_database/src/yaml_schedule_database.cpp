#include <yaml_database/yaml_schedule_database.h>

#include <iostream>
#include <string>

namespace tabetai2::yaml_database {

using namespace core::database;
using namespace core::recipe;
using namespace core::schedule;

YamlScheduleDatabase::YamlScheduleDatabase(std::string database_file,
                                           std::string database_name,
                                           std::shared_ptr<RecipeRepository> recipe_repository)
: YamlDatabase<Schedule>{std::move(database_file), std::move(database_name)},
  m_recipe_repository{std::move(recipe_repository)} {

}

Schedule YamlScheduleDatabase::from_yaml(YAML::Node entry) const {
    Schedule schedule{entry["id"].as<Id>(), entry["start_date"].as<std::string>()};
    for (const auto& day_entry : entry["days"]) {
        ScheduleDay day;
        for (const auto& meal_entry : day_entry) {
            auto recipe = m_recipe_repository->find_by_id(meal_entry["recipe"].as<Id>());
            if (!recipe) {
                std::cout << "Non-existing recipe referenced in schedule." << std::endl;
            }

            auto servings = meal_entry["servings"].as<unsigned>();
            Meal meal{recipe.value(), servings};
            day.add_meal(meal);
        }

        schedule.add_day(day);
    }

    return schedule;
}

YAML::Node YamlScheduleDatabase::to_yaml(const Schedule& schedule) const {
    YAML::Node entry;
    entry["id"] = schedule.id();
    entry["start_date"] = schedule.start_date();

    size_t day_index = 0;
    for (const auto& day : schedule.days()) {
        size_t meal_index = 0;
        for (const auto& meal : day.meals()) {
            entry["days"][day_index][meal_index]["recipe"] = meal.recipe().id();
            entry["days"][day_index][meal_index]["servings"] = meal.servings();
            ++meal_index;
        }

        ++day_index;
    }

    return entry;
}

}

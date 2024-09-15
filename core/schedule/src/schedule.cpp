#include <schedule/schedule.h>

#include <algorithm>
#include <iostream>
#include <map>
#include <optional>
#include <utility>

#include "database/database.h"
#include "ingredient/ingredient.h"
#include "schedule/recipe_meal.h"
#include "schedule/schedule_summary.h"

namespace tabetai2::core::schedule {

using namespace core::database;
using namespace core::recipe;

Schedule::Schedule(Id id, std::string start_date) : m_id{id}, m_start_date{std::move(start_date)}, m_days{} {}

Id Schedule::id() const {
    return m_id;
}

std::string Schedule::start_date() const {
    return m_start_date;
}

const std::vector<ScheduleDay> &Schedule::days() const {
    return m_days;
}

void Schedule::add_day(ScheduleDay day) {
    m_days.push_back(std::move(day));
}

ScheduleSummary Schedule::summary() const {
    std::vector<std::pair<ingredient::Ingredient, std::vector<std::optional<recipe::Quantity>>>> res;
    std::map<std::string, std::pair<ingredient::Ingredient, std::vector<std::optional<recipe::Quantity>>>> mapper;
    for (const auto &day : m_days) {
        for (const auto &meal : day.meals()) {
            if (meal->type() != MealType::Recipe) {
                continue;
            }

            auto &recipe_meal = dynamic_cast<const RecipeMeal &>(*meal);

            auto recipe_ingredients = recipe_meal.recipe().ingredients();
            auto recipe_servings = recipe_meal.recipe().servings();
            for (const auto &recipe_ingredient : recipe_ingredients) {
                double amount = 0;
                std::pair<ingredient::Ingredient, std::optional<recipe::Quantity>> ing =
                    std::make_pair(recipe_ingredient.first, std::nullopt);
                auto key = std::to_string(recipe_ingredient.first.id());
                if (recipe_ingredient.second.has_value() && recipe_ingredient.second->amount() != 0) {
                    amount = ((recipe_ingredient.second->amount() / recipe_servings) * recipe_meal.servings());
                    ing.second = Quantity(amount, recipe_ingredient.second->unit());
                }

                auto entry = mapper.find(key);
                if (entry != mapper.end()) {
                    auto &existing_ing = entry->second;
                    if (ing.second) {
                        existing_ing.second.push_back(ing.second);
                    }

                } else {
                    std::vector<std::optional<recipe::Quantity>> vec;
                    if (ing.second) {
                        vec.push_back(ing.second);
                    }
                    std::pair<ingredient::Ingredient, std::vector<std::optional<recipe::Quantity>>> new_ing =
                        std::make_pair(ing.first, vec);
                    mapper.insert({key, new_ing});
                }
            }
        }
    }

    for (auto const &[_, value] : mapper) {
        res.push_back(value);
    }

    std::ranges::sort(res, [](const auto &a, const auto &b) { return a.first.name() < b.first.name(); });
    return ScheduleSummary(res);
}

}  // namespace tabetai2::core::schedule

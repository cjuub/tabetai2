#include <memory>
#include <vector>

#include "schedule/external_recipe_meal.h"
#include "schedule/leftovers_meal.h"
#include "schedule/meal.h"
#include "schedule/other_meal.h"
#include "schedule/recipe_meal.h"

namespace tabetai2::core::schedule {

class ScheduleDay {
public:
    ScheduleDay() = default;

    ScheduleDay(const ScheduleDay& other) {
        for (const auto& meal : other.m_meals) {
            if (RecipeMeal* recipe_meal = dynamic_cast<RecipeMeal*>(meal.get())) {
                m_meals.push_back(std::make_unique<RecipeMeal>(
                    recipe_meal->recipe(), recipe_meal->servings(), recipe_meal->comment()));
            } else if (ExternalRecipeMeal* external_recipe_meal = dynamic_cast<ExternalRecipeMeal*>(meal.get())) {
                m_meals.push_back(std::make_unique<ExternalRecipeMeal>(external_recipe_meal->title(),
                                                                       external_recipe_meal->url(),
                                                                       external_recipe_meal->servings(),
                                                                       external_recipe_meal->comment()));
            } else if (LeftoversMeal* leftover_meal = dynamic_cast<LeftoversMeal*>(meal.get())) {
                m_meals.push_back(std::make_unique<LeftoversMeal>(
                    leftover_meal->title(), leftover_meal->servings(), leftover_meal->comment()));
            } else if (OtherMeal* other_meal = dynamic_cast<OtherMeal*>(meal.get())) {
                m_meals.push_back(
                    std::make_unique<OtherMeal>(other_meal->title(), other_meal->servings(), other_meal->comment()));
            } else {
                throw std::runtime_error("Unknown meal type.");
            }
        }
    };

    ScheduleDay(ScheduleDay&& other) {
        m_meals = std::move(other.m_meals);
    };

    ScheduleDay& operator=(const ScheduleDay& other) {
        if (this == &other) {
            return *this;
        }

        m_meals.clear();
        for (const auto& meal : other.m_meals) {
            if (RecipeMeal* recipe_meal = dynamic_cast<RecipeMeal*>(meal.get())) {
                m_meals.push_back(std::make_unique<RecipeMeal>(
                    recipe_meal->recipe(), recipe_meal->servings(), recipe_meal->comment()));
            } else if (ExternalRecipeMeal* external_recipe_meal = dynamic_cast<ExternalRecipeMeal*>(meal.get())) {
                m_meals.push_back(std::make_unique<ExternalRecipeMeal>(external_recipe_meal->title(),
                                                                       external_recipe_meal->url(),
                                                                       external_recipe_meal->servings(),
                                                                       external_recipe_meal->comment()));
            } else if (LeftoversMeal* leftover_meal = dynamic_cast<LeftoversMeal*>(meal.get())) {
                m_meals.push_back(std::make_unique<LeftoversMeal>(
                    leftover_meal->title(), leftover_meal->servings(), leftover_meal->comment()));
            } else if (OtherMeal* other_meal = dynamic_cast<OtherMeal*>(meal.get())) {
                m_meals.push_back(
                    std::make_unique<OtherMeal>(other_meal->title(), other_meal->servings(), other_meal->comment()));
            } else {
                throw std::runtime_error("Unknown meal type.");
            }
        }

        return *this;
    }

    ScheduleDay& operator=(ScheduleDay&& other) {
        if (this == &other) {
            return *this;
        }

        m_meals = std::move(other.m_meals);

        return *this;
    }

    ~ScheduleDay() = default;

    void add_meal(std::unique_ptr<Meal> meal);

    const std::vector<std::unique_ptr<Meal>>& meals() const;

private:
    std::vector<std::unique_ptr<Meal>> m_meals;
};

}  // namespace tabetai2::core::schedule

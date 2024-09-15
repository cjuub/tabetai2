#include <schedule/schedule_day.h>

#include "schedule/meal.h"

namespace tabetai2::core::schedule {

void ScheduleDay::add_meal(std::unique_ptr<Meal> meal) {
    m_meals.push_back(std::move(meal));
}

const std::vector<std::unique_ptr<Meal>>& ScheduleDay::meals() const {
    return m_meals;
}

}  // namespace tabetai2::core::schedule

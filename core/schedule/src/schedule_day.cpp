#include <schedule/schedule_day.h>

namespace tabetai2::core::schedule {

void ScheduleDay::add_meal(const Meal &meal) {
    m_meals.push_back(meal);
}

std::vector<Meal> ScheduleDay::meals() const {
    return m_meals;
}

}  // namespace tabetai2::core::schedule

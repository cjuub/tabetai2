#include <memory>
#include <vector>

#include "schedule/meal.h"

namespace tabetai2::core::schedule {

class ScheduleDay {
public:
    ScheduleDay() = default;

    ScheduleDay(const ScheduleDay& other) {
        for (const auto& meal : other.m_meals) {
            m_meals.push_back(std::make_unique<Meal>(*meal));
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
            m_meals.push_back(std::make_unique<Meal>(*meal));
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

#include <schedule/meal.h>

#include <vector>

namespace tabetai2::core::schedule {

class ScheduleDay {
public:
    ScheduleDay() = default;

    void add_meal(const Meal& meal);

    std::vector<Meal> meals() const;

private:
    std::vector<Meal> m_meals;
};

}  // namespace tabetai2::core::schedule
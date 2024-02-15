#include "schedule/schedule_summary.h"

namespace tabetai2::core::schedule {

using namespace core::ingredient;
using namespace core::recipe;

ScheduleSummary::ScheduleSummary(std::vector<std::pair<Ingredient, std::vector<std::optional<Quantity>>>> ingredients) :
m_ingredients{ingredients} {}

std::vector<std::pair<Ingredient, std::vector<std::optional<Quantity>>>> ScheduleSummary::ingredients() const {
    return m_ingredients;
}

}  // namespace tabetai2::core::schedule

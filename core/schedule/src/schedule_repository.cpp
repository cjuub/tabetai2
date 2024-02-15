#include <schedule/schedule_repository.h>

#include <stdexcept>

namespace tabetai2::core::schedule {

using namespace core::database;

std::optional<Schedule> ScheduleRepository::find_by_id(Id id) const try {
    return m_database->get(id);
} catch (const std::out_of_range &) {
    return std::nullopt;
}

}  // namespace tabetai2::core::schedule

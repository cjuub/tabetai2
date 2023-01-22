#include <schedule/schedule.h>

namespace tabetai2::core::schedule {

using namespace core::database;

Schedule::Schedule(Id id, std::string start_date)
: m_id{id},
  m_start_date{std::move(start_date)},
  m_days{} {

}

Id Schedule::id() const {
    return m_id;
}

std::string Schedule::start_date() const {
    return m_start_date;
}

std::vector<ScheduleDay> Schedule::days() const {
    return m_days;
}

void Schedule::add_day(const ScheduleDay& day) {
    m_days.push_back(day);
}

}

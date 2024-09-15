#pragma once

#include <database/database.h>
#include <schedule/schedule_day.h>

#include <string>

#include "schedule/schedule_summary.h"

namespace tabetai2::core::schedule {

class Schedule {
public:
    Schedule(database::Id id, std::string start_date);

    database::Id id() const;

    void add_day(ScheduleDay day);

    std::string start_date() const;

    const std::vector<ScheduleDay>& days() const;

    ScheduleSummary summary() const;

    bool operator<(const Schedule& r) const {
        return m_id < r.m_id;
    }

    bool operator==(const Schedule& r) const {
        return m_id == r.m_id;
    }

private:
    database::Id m_id;
    std::string m_start_date;
    std::vector<ScheduleDay> m_days;
};

}  // namespace tabetai2::core::schedule

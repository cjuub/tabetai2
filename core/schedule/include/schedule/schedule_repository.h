#pragma once

#include <optional>
#include <repository/repository.hpp>

#include "schedule.h"

namespace tabetai2::core::schedule {

class ScheduleRepository : public repository::Repository<Schedule> {
public:
    using Repository<Schedule>::Repository;

    std::optional<Schedule> find_by_id(database::Id id) const;
};

}  // namespace tabetai2::core::schedule

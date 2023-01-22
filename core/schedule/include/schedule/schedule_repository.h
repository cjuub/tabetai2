#pragma once

#include <repository/repository.hpp>

#include "schedule.h"

#include <memory>
#include <optional>

namespace tabetai2::core::schedule {

class ScheduleRepository : public repository::Repository<Schedule> {
public:
    using Repository<Schedule>::Repository;

    std::optional<Schedule> find_by_id(database::Id id) const;
};

}

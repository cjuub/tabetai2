#pragma once

#include "database.h"

namespace tabetai2::core::database {

class IdGenerator {
public:
    virtual Id generate() = 0;

    virtual ~IdGenerator() = default;
};

}  // namespace tabetai2::core::database

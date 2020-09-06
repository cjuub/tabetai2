#pragma once

#include <database/id_generator.h>

#include <memory>

namespace tabetai2::core::database {

class IdGeneratorFactory {
public:
    static std::shared_ptr<IdGenerator> create();
};

}

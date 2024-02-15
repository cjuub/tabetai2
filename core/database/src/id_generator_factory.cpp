#include <database/id_generator_factory.h>

#include "impl/id_generator.h"

namespace tabetai2::core::database {

std::shared_ptr<IdGenerator> IdGeneratorFactory::create() {
    return std::make_shared<impl::IdGenerator>();
}

}  // namespace tabetai2::core::database

#include "id_generator.h"

namespace tabetai2::core::database::impl {

IdGenerator::IdGenerator() : m_engine(std::random_device()()), m_distribution{} {

}

Id IdGenerator::generate() {
    return m_distribution(m_engine);
}

}

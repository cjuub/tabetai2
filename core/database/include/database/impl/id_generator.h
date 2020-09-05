#pragma once

#include <database/id_generator.h>

#include <random>

namespace tabetai2::core::database::impl {

class IdGenerator : public database::IdGenerator {
public:
    IdGenerator() : m_engine(std::random_device()()), m_distribution{} {}

    Id generate() override {
        return m_distribution(m_engine);
    }

private:
    std::mt19937 m_engine;
    std::uniform_int_distribution<uint64_t> m_distribution;
};

}
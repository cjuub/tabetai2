#pragma once

#include <database/id_generator.h>

#include <random>

namespace tabetai2::core::database::impl {

class IdGenerator : public database::IdGenerator {
public:
    IdGenerator();

    Id generate() override;

private:
    std::mt19937 m_engine;
    std::uniform_int_distribution<uint64_t> m_distribution;
};

}
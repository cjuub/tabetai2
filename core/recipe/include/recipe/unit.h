#pragma once

#include <string>

namespace tabetai2::core::recipe {

enum class Unit {
    G,
    HG,
    KG,

    KRM,
    MSK,
    ML,
    DL,
    L,

    PCS
};

constexpr std::string unit_as_string(Unit unit) {
    switch (unit) {
        case Unit::G:
            return "g";
        case Unit::HG:
            return "hg";
        case Unit::KG:
            return "kg";
        case Unit::KRM:
            return "krm";
        case Unit::MSK:
            return "msk";
        case Unit::ML:
            return "ml";
        case Unit::DL:
            return "dl";
        case Unit::L:
            return "l";
        case Unit::PCS:
            return "pcs";
        default:
            return "bad";
    }
}

}  // namespace tabetai2::core::recipe

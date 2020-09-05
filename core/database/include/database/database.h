#pragma once

#include <cstdint>
#include <vector>

namespace tabetai2::core::database {

using Id = uint64_t;

template<class T>
class Database {
public:
    virtual void add(T t) = 0;
    virtual void erase(Id id) = 0;
    virtual T get(Id id) const = 0;
    virtual std::vector<T> get_all() const = 0;

    virtual ~Database() = default;
};

}

#pragma once

#include <vector>

namespace tabetai2::core::database {

template<class T>
class Database {
public:
    virtual void add(T t) = 0;
    virtual void erase(int id) = 0;
    virtual T get(int id) const = 0;
    virtual std::vector<T> get_all() const = 0;

    virtual ~Database() = default;
};

}

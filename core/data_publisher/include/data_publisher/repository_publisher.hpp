#pragma once

#include "publisher.h"

#include <repository/repository.hpp>
#include <util/observer.h>

#include <memory>
#include <iostream>

namespace tabetai2::core::data_publisher {

template<class T>
class RepositoryPublisher : public Publisher, public util::Observer {
public:
    explicit RepositoryPublisher(const std::shared_ptr<repository::Repository<T>>& repository) {
        repository->add_observer(this);
    }

private:
    void notify() override {
        publish();
    }
};

}
#pragma once

#include "repository/repository.hpp"
#include "ingredient/ingredient_repository.h"

#include <util/observer.h>
#include <util/publisher.h>

#include <memory>
#include <iostream>

namespace tabetai2::core::repository {

template<class T>
class RepositoryPublisher : public util::Publisher, public util::Observer {
public:
    explicit RepositoryPublisher(const std::shared_ptr<Repository<T>>& repository) {
        repository->add_observer(this);
    }

    void publish() override {
        std::cout << "Publishing repository" << std::endl;
    }

private:
    void notify() override {
        publish();
    }
};

}
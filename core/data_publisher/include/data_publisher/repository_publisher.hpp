#pragma once

#include <util/observer.h>

#include <memory>
#include <repository/repository.hpp>

#include "publisher.h"

namespace tabetai2::core::data_publisher {

template <class T>
class RepositoryPublisher : public Publisher, public util::Observer {
public:
    explicit RepositoryPublisher(const std::shared_ptr<repository::Repository<T>> &repository) :
    m_repository(repository) {
        m_repository->add_observer(this);
    }

    ~RepositoryPublisher() {
        m_repository->remove_observer(this);
    }

private:
    std::shared_ptr<repository::Repository<T>> m_repository;

    void notify() override {
        publish();
    }
};

}  // namespace tabetai2::core::data_publisher

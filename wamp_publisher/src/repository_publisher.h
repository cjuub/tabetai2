#pragma once

#include <data_publisher/repository_publisher.hpp>

namespace tabetai2::wamp_publisher {

template <class T>
class RepositoryPublisher : public core::data_publisher::RepositoryPublisher<T> {
public:
    using core::data_publisher::RepositoryPublisher<T>::RepositoryPublisher;

    void publish() override {
        std::cout << "Publishing repository with wamp" << std::endl;
    }
};

}

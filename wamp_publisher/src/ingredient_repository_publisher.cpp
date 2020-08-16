#include "ingredient_repository_publisher.h"

#include <iostream>

namespace tabetai2::wamp_publisher {

void IngredientRepositoryPublisher::publish() {
    std::cout << "Publishing ingredient repository with wamp" << std::endl;
}

}

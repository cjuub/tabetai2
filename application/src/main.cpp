#include "server/server_factory.h"

#include <database/id_generator_factory.h>
#include <iostream>

using namespace tabetai2::core::database;
using namespace tabetai2::core::server;

int main() {
    std::cout << "Starting Tabetai2" << std::endl;
    std::unique_ptr<Server> server;
}

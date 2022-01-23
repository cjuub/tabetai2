#include <application_server/server_factory.h>

#include <iostream>


using namespace tabetai2::application_server;

int main() {
    std::cout << "Starting Tabetai2" << std::endl;
    ServerFactory().create()->run();
}

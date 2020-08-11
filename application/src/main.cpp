#include "server_factory.h"

using namespace tabetai2::application;

int main() {
    ServerFactory().create()->run();
}

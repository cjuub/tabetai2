#include "server/server_factory.h"

int main() {
    tabetai2::core::server::ServerFactory().create()->run();
}

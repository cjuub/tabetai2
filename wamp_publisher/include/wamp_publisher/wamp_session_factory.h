#pragma once

#include "wamp_session.h"

#include <memory>

namespace tabetai2::wamp_publisher {

class WampSessionFactory {
public:
    static std::unique_ptr<WampSession> create();
};

}

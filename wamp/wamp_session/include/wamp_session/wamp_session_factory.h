#pragma once

#include "wamp_session.h"

#include <memory>

namespace tabetai2::wamp_session {

class WampSessionFactory {
public:
    static std::unique_ptr<WampSession> create();
};

}

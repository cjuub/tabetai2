#include <wamp_publisher/wamp_session_factory.h>

#include "impl/wamp_session.h"

namespace tabetai2::wamp_publisher {

std::unique_ptr<WampSession> WampSessionFactory::create() {
    return std::make_unique<impl::WampSession>();
}

}

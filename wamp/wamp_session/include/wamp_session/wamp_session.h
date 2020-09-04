#pragma once

#include <wamp_data/publishable.h>

#include <any>
#include <functional>
#include <string>
#include <variant>

namespace tabetai2::wamp_session {

class WampSession {
public:
    virtual void run(std::function<void(WampSession&)> func) = 0;

    virtual void publish(const std::string& topic, const wamp_data::Publishable& object) = 0;

    template<typename... Ts>
    void create_rpc(const std::string& topic, const std::function<void(Ts...)>& rpc) {
        create_rpc_impl(topic, [rpc](const std::vector<std::any>& args) {
            std::apply(rpc, ArgHelper<Ts...>::unpack(args));
        });
    }

    virtual ~WampSession() = default;

private:
    template<typename... Ts>
    class ArgHelper {
    public:
        constexpr static std::tuple<Ts...> unpack(const std::vector<std::any>& args) {
            return unpack(std::make_index_sequence<sizeof...(Ts)>{}, args);
        }

        template<std::size_t... Is>
        constexpr static std::tuple<Ts...> unpack(
                const std::index_sequence<Is...> &,
                const std::vector<std::any>& args) {
            return std::make_tuple(std::any_cast<Ts>(args[Is])...);
        }
    };

    virtual void create_rpc_impl(const std::string& topic, const std::function<void(std::vector<std::any>)>& rpc) = 0;
};

}

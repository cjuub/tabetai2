load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "autobahn-cpp",
    hdrs = glob([
        "autobahn/**/*.hpp",
        "autobahn/**/*.ipp",
    ]),
    includes = ["."],
    visibility = ["//visibility:public"],
    deps = [
        "@boost//:asio",
        "@boost//:thread",
        "@msgpack-c",
        "@websocketpp",
    ],
)

cc_library(
    name = "examples_parameters",
    srcs = ["examples/parameters.cpp"],
    hdrs = ["examples/parameters.hpp"],
    deps = [
        "@boost//:asio",
        "@boost//:program_options",
        "@msgpack-c",
        "@websocketpp",
    ],
)

cc_binary(
    name = "subscriber",
    srcs = ["examples/subscriber.cpp"],
    deps = [
        ":autobahn-cpp",
        ":examples_parameters",
        "@boost//:asio",
    ],
)

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "websocketpp",
    hdrs = glob(["websocketpp/**/*.hpp"]),
    visibility = ["//visibility:public"],
    deps = [
        "@boringssl//:ssl",
        "@zlib",
    ],
)

cc_binary(
    name = "dev",
    srcs = ["examples/dev/main.cpp"],
    deps = [
        ":websocketpp",
        "@boost//:timer",
    ],
)

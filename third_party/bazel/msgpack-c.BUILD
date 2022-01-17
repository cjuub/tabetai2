load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "msgpack-c",
    hdrs = glob(["include/**/*.hpp"]),
    strip_include_prefix = "include/",
    visibility = ["//visibility:public"],
    deps = [
        "@boost//:predef",
        "@boost//:variant",
    ],
)

cc_binary(
    name = "container",
    srcs = ["example/cpp11/container.cpp"],
    deps = [
        ":msgpack-c",
    ],
)

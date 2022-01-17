load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "wamp_session",
    srcs = glob(["src/**"]),
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//wamp/wamp_data",
        "@autobahn-cpp",
    ],
)

load("@rules_cc//cc:defs.bzl", "cc_binary")

cc_binary(
    name = "application",
    srcs = ["src/main.cpp"],
    deps = [
        "//core/database",
        "//core/server",
        "//wamp/wamp_publisher",
        "//wamp/wamp_session",
    ],
)

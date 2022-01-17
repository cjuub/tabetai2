load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "wamp_publisher",
    srcs = glob(["src/**"]),
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//core/data_publisher",
        "//core/ingredient",
        "//core/recipe",
        "//wamp/wamp_data",
        "//wamp/wamp_session",
    ],
)

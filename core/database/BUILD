load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "database",
    srcs = glob(["src/**"]),
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "@range-v3",
    ],
)

load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "repository",
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//core/database",
        "//core/util",
    ],
)

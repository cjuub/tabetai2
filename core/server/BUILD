load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "server",
    srcs = glob(["src/**"]),
    hdrs = glob(["include/**"]),
    copts = ["-Icore/server/src"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//core/data_publisher",
        "//core/ingredient",
        "//core/recipe",
        "//yaml_database",
    ],
)

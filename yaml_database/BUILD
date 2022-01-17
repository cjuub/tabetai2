load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "yaml_database",
    srcs = glob(["src/**"]),
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//core/database",
        "//core/ingredient",
        "//core/recipe",
        "@range-v3",
        "@yaml-cpp",
    ],
)

load("@rules_cc//cc:defs.bzl", "cc_library", "cc_test")

cc_library(
    name = "data_publisher",
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//core/ingredient",
        "//core/recipe",
        "//core/repository",
        "//core/util",
    ],
)

cc_test(
    name = "data_publisher_test",
    srcs = glob(["test/src/**"]),
    deps = [
        ":data_publisher",
        "@catch2",
    ],
)

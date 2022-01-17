load("@rules_cc//cc:defs.bzl", "cc_library", "cc_test")

cc_library(
    name = "recipe",
    srcs = glob(["src/**"]),
    hdrs = glob(["include/**"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        "//core/ingredient",
        "//core/repository",
        "@range-v3",
    ],
)

cc_test(
    name = "recipe_test",
    srcs = glob(["test/src/**"]),
    deps = [
        ":recipe",
        "@catch2",
    ],
)

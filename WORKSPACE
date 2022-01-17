load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "autobahn-cpp",
    build_file = "//third_party/bazel:autobahn-cpp.BUILD",
    sha256 = "c651ad947f815c991e20d9c083bca9b4de722af75b3b0929e9ed502f15c5609f",
    strip_prefix = "autobahn-cpp-781686678d9606e77ad12cf79ba85aadf4e3d63d",
    url = "https://github.com/crossbario/autobahn-cpp/archive/781686678d9606e77ad12cf79ba85aadf4e3d63d.tar.gz",
)

http_archive(
    name = "boringssl",
    sha256 = "e168777eb0fc14ea5a65749a2f53c095935a6ea65f38899a289808fb0c221dc4",
    strip_prefix = "boringssl-4fb158925f7753d80fb858cb0239dff893ef9f15",
    url = "https://github.com/google/boringssl/archive/4fb158925f7753d80fb858cb0239dff893ef9f15.tar.gz",
)

http_archive(
    name = "catch2",
    sha256 = "b9b592bd743c09f13ee4bf35fc30eeee2748963184f6bea836b146e6cc2a585a",
    strip_prefix = "Catch2-2.13.8",
    url = "https://github.com/catchorg/Catch2/archive/v2.13.8.tar.gz",
)

http_archive(
    name = "com_github_nelhage_rules_boost",
    sha256 = "2d0b2eef7137730dbbb180397fe9c3d601f8f25950c43222cb3ee85256a21869",
    strip_prefix = "rules_boost-fce83babe3f6287bccb45d2df013a309fa3194b8",
    url = "https://github.com/nelhage/rules_boost/archive/fce83babe3f6287bccb45d2df013a309fa3194b8.tar.gz",
)

load("@com_github_nelhage_rules_boost//:boost/boost.bzl", "boost_deps")

boost_deps()

http_archive(
    name = "msgpack-c",
    build_file = "//third_party/bazel:msgpack-c.BUILD",
    sha256 = "9b3c1803b9855b7b023d7f181f66ebb0d6941275ba41d692037e0aa27736443f",
    strip_prefix = "msgpack-cxx-4.0.3",
    url = "https://github.com/msgpack/msgpack-c/releases/download/cpp-4.0.3/msgpack-cxx-4.0.3.tar.gz",
)

http_archive(
    name = "range-v3",
    sha256 = "3575e4645cd1a7d42fa42a6b016e75a7c72d31d13f72ee4e5bb9773d36303258",
    strip_prefix = "range-v3-83783f578e0e6666d68a3bf17b0038a80e62530e",
    url = "https://github.com/ericniebler/range-v3/archive/83783f578e0e6666d68a3bf17b0038a80e62530e.tar.gz",
)

http_archive(
    name = "websocketpp",
    build_file = "//third_party/bazel:websocketpp.BUILD",
    sha256 = "6ce889d85ecdc2d8fa07408d6787e7352510750daa66b5ad44aacb47bea76755",
    strip_prefix = "websocketpp-0.8.2",
    url = "https://github.com/zaphoyd/websocketpp/archive/0.8.2.tar.gz",
)

http_archive(
    name = "yaml-cpp",
    sha256 = "43e6a9fcb146ad871515f0d0873947e5d497a1c9c60c58cb102a97b47208b7c3",
    strip_prefix = "yaml-cpp-yaml-cpp-0.7.0",
    url = "https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.7.0.tar.gz",
)

http_archive(
    name = "zlib",
    build_file = "//third_party/bazel:zlib.BUILD",
    sha256 = "629380c90a77b964d896ed37163f5c3a34f6e6d897311f1df2a7016355c45eff",
    strip_prefix = "zlib-1.2.11",
    url = "https://github.com/madler/zlib/archive/v1.2.11.tar.gz",
)

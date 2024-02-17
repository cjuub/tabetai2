# tabetai2

## Build

### With CMakePresets (recommended)
Uses Ninja and Conan by default, and no need to export environment variables.
```
cmake --preset Debug
cmake --build --preset Debug
```

### With Conan
Faster than FetchContent for clean builds, but requires Conan 2.x.
```
export GRPC_DART_PLUGIN=~/.pub-cache/bin/protoc-gen-dart

mkdir -p build/Debug
cmake -B build/Debug -S . -DCMAKE_BUILD_TYPE=Debug -DTABETAI2_USE_CONAN=1
cmake --build build/Debug -j32
```

### With FetchContent
Slowest as it downloads and builds the dependencies from source.
```
export GRPC_DART_PLUGIN=~/.pub-cache/bin/protoc-gen-dart

mkdir -p build/Debug
cmake -B build/Debug -S . -DCMAKE_BUILD_TYPE=Debug
cmake --build build/Debug -j32
```

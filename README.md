# tabetai2

## Build

### With CMakePresets (recommended)
```
cmake --preset Debug
cmake --build --preset Debug
```

### Without CMakePresets
```
export GRPC_DART_PLUGIN=~/.pub-cache/bin/protoc-gen-dart

mkdir -p build/Debug
cmake -B build/Debug -S . -DCMAKE_BUILD_TYPE=Debug
cmake --build build/Debug
```

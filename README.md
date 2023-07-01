# tabetai2

## Build

### With Conan
```
conan install . --output-folder=build --build=missing -s build_type=Debug
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DTABETAI2_USE_CONAN=TRUE
cmake --build . -j32
```

### With FetchContent
```
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake --build . -j32
```


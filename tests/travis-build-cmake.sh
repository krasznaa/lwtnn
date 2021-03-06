#!/usr/bin/env bash

if [[ $- == *i* ]]; then
    echo "don't source me!" >&2
    return 1
fi

set -eu

if [[ -d build ]]; then
    echo "removing old build directory" >&2
    rm -r build
fi
mkdir build

pushd .
cd build
ARGS=''
if [[ ${MINIMAL+x} ]]; then
    ARGS="-DBUILTIN_BOOST=TRUE -DBUILTIN_EIGEN=TRUE"
fi
cmake ${ARGS} ..
make -j 4
popd

if [[ -d bin ]]; then
    echo "removing old bin directory" >&2
    rm -r bin
fi
mv build/bin .


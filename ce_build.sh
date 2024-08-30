#!/bin/bash

export TOOL_PREFIX=`which arm-mingw32ce-gcc | sed "s/-gcc$//"`

export HOST_ARCH=arm-none-linux-gnu
export TOOL_PREFIX=${TOOL_PREFIX:-/usr/bin/arm-mingw32ce}
export CC=$TOOL_PREFIX-gcc
export CXX=$TOOL_PREFIX-g++
export CPP="$TOOL_PREFIX-g++ -E"
export AR=$TOOL_PREFIX-ar
export RANLIB=$TOOL_PREFIX-ranlib
export LD=$TOOL_PREFIX-ld
export READELF=$TOOL_PREFIX-readelf
export WINDRES=$TOOL_PREFIX-windres
export LIBS="-lcoredll6 -lcoredll -lm -laygshell -lws2 -lcommctrl"
export CFLAGS="-march=armv5tej -mcpu=arm926ej-s -Wno-attributes -DWC_NO_BEST_FIT_CHARS -D_WIN32_WCE=0x0600 -D_MAX_PATH=260 -D_UNICODE -DUNICODE -DPy_HAVE_ZLIB=1 -DLACK_OF_CRYPT_API -fvisibility=hidden -fno-pic"
export LDFLAGS="-fno-strict-aliasing"
export CPPFLAGS="-fvisibility=hidden"

function err() {
    echo "error!" 1>&2
    exit 1
}

touch make.log

./configure CC=$CC CXX=$CXX --host=arm-mingw32ce \
 |& tee make.log -a || err

cd arm-unknown-mingw32ce
make -j $(nproc) |& tee ../make.log -a || err


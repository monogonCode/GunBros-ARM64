#!/bin/bash
set -e

DIR="/home/martin/Documentos/gunbros"
TOOLCHAIN_ROOT="/home/martin/Proyectos/GunBros16"
NDK="$TOOLCHAIN_ROOT/tools/android-ndk-r26d"
CLANG="$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/clang"
CLANGXX="$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++"
STRIP="$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip"
BUILD_TOOLS="$TOOLCHAIN_ROOT/android-sdk/build-tools/34.0.0"

echo "[1/4] Compiling dynarmic_backend.cpp (C++20)..."
$CLANGXX --target=aarch64-linux-android30 -std=c++20 -fPIC -O3 \
  -I"$TOOLCHAIN_ROOT/dynarmic/src" \
  -I"$TOOLCHAIN_ROOT/dynarmic/externals/oaknut/include" \
  -I"$TOOLCHAIN_ROOT/dynarmic/externals/fmt/include" \
  -I"$TOOLCHAIN_ROOT/dynarmic/externals/mcl/include" \
  -I"$TOOLCHAIN_ROOT/dynarmic/externals/robin-map/include" \
  -isystem "$TOOLCHAIN_ROOT/boost/usr/include" \
  -I"$DIR" \
  -c "$DIR/dynarmic_backend.cpp" \
  -o "$DIR/dynarmic_backend.o"

echo "[2/4] Compiling arm64_bridge_dynarmic.c and pcm_ring.c (C)..."
$CLANG --target=aarch64-linux-android30 -fPIC -O3 \
  -I"$DIR" \
  -c "$DIR/arm64_bridge_dynarmic.c" \
  -o "$DIR/arm64_bridge_dynarmic.o"

$CLANG --target=aarch64-linux-android30 -std=c99 -fPIC -O3 \
  -I"$DIR" \
  -c "$DIR/pcm_ring.c" \
  -o "$DIR/pcm_ring.o"

echo "[3/4] Linking libandroidplatformjni.so..."
$CLANGXX --target=aarch64-linux-android30 -shared -fPIC -O3 \
  -static-libstdc++ \
  "$DIR/arm64_bridge_dynarmic.o" "$DIR/pcm_ring.o" \
  "$DIR/dynarmic_backend.o" \
  "$TOOLCHAIN_ROOT/dynarmic/build-arm64/src/dynarmic/libdynarmic.a" \
  "$TOOLCHAIN_ROOT/dynarmic/build-arm64/externals/fmt/libfmt.a" \
  "$TOOLCHAIN_ROOT/dynarmic/build-arm64/externals/mcl/src/libmcl.a" \
  -llog -laaudio -lEGL -lGLESv1_CM -landroid -lm \
  -Wl,-soname,libandroidplatformjni.so \
  -o "$DIR/libandroidplatformjni.so"

$STRIP --strip-unneeded "$DIR/libandroidplatformjni.so"
echo "Built libandroidplatformjni.so ($(ls -lh "$DIR/libandroidplatformjni.so" | awk '{print $5}'))"

echo "[4/4] Injecting into APK, zipaligning and signing..."
mkdir -p /tmp/gunbros_apk_update/lib/arm64-v8a
cp "$DIR/libandroidplatformjni.so" /tmp/gunbros_apk_update/lib/arm64-v8a/libandroidplatformjni.so
cp "$DIR/base_template.apk" "$DIR/gunbros_unaligned.apk"
(cd /tmp/gunbros_apk_update && zip -0 -u "$DIR/gunbros_unaligned.apk" lib/arm64-v8a/libandroidplatformjni.so)

rm -f "$DIR/GunBros_Android16_Dynarmic.apk"
"$BUILD_TOOLS/zipalign" -p -f 4 "$DIR/gunbros_unaligned.apk" "$DIR/GunBros_Android16_Dynarmic.apk"
"$BUILD_TOOLS/apksigner" sign --ks "$TOOLCHAIN_ROOT/debug.keystore" --ks-pass pass:android "$DIR/GunBros_Android16_Dynarmic.apk"
"$BUILD_TOOLS/apksigner" verify "$DIR/GunBros_Android16_Dynarmic.apk"
rm -f "$DIR/gunbros_unaligned.apk"

echo "=== SUCCESS! $DIR/GunBros_Android16_Dynarmic.apk is ready ==="

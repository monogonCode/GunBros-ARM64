#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Cargar entorno y resolver dependencias desde .env
source "$SCRIPT_DIR/common_env.sh"

if [[ -z "$NDK" || ! -f "$NDK/build/cmake/android.toolchain.cmake" ]]; then
    echo "ERROR: Android NDK no válido en '$NDK'." >&2
    echo "Configura ANDROID_NDK_HOME en tu archivo .env o define la variable de entorno." >&2
    exit 1
fi

BUILD_DIR="$PROJECT_ROOT/build/android"

echo "=== [GunBros Build] Starting ARM64 NDK CMake Build ==="
echo "  NDK:      $NDK"
echo "  CMake:    $CMAKE_BIN"
echo "  Dynarmic: $DYNARMIC_ROOT"
echo "  Boost:    $BOOST_ROOT"

"$CMAKE_BIN" -B "$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$NDK/build/cmake/android.toolchain.cmake" \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_PLATFORM=android-30 \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TESTING=OFF \
  -DDYNARMIC_ROOT="$DYNARMIC_ROOT" \
  -DBOOST_ROOT="$BOOST_ROOT" \
  -S "$PROJECT_ROOT"

"$CMAKE_BIN" --build "$BUILD_DIR" --target androidplatformjni -j"$(nproc)"

SO_PATH="$BUILD_DIR/libandroidplatformjni.so"
"$STRIP" --strip-unneeded "$SO_PATH"
echo "[GunBros Build] Stripped $SO_PATH ($(ls -lh "$SO_PATH" | awk '{print $5}'))"

# Copy output to root directory for backward compatibility
cp "$SO_PATH" "$PROJECT_ROOT/libandroidplatformjni.so"

# Package and sign APK
"$SCRIPT_DIR/package.sh" "$SO_PATH"

echo "=== [GunBros Build] Build and APK packaging complete! ==="

#!/bin/sh
# Uso: ANDROID_NDK_HOME=/ruta/al/ndk ./build_guest_helpers.sh
set -e
BIN="${ANDROID_NDK_HOME:?define ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin"
# armv5te + modo ARM: lo ejecuta cualquier modelo de CPU de Unicorn (sin movw/movt/udiv)
"$BIN/clang" --target=arm-linux-androideabi21 -march=armv5te -marm -O2 \
  -ffreestanding -fno-builtin -fno-pic -fno-stack-protector \
  -fno-unwind-tables -fno-asynchronous-unwind-tables -nostdlib \
  -c guest_helpers.c -o guest_helpers.o
"$BIN/llvm-objcopy" -O binary -j .text guest_helpers.o guest_helpers.bin
echo "--- comprueba: guest_qsort en offset 0 y ningun 'bl' a otras funciones ---"
"$BIN/llvm-objdump" -d guest_helpers.o | head -60
if command -v xxd >/dev/null 2>&1; then
  xxd -i guest_helpers.bin > guest_helpers_bin.h
else  # fallback sin xxd (macOS minimal / contenedores)
  python3 - <<'PY'
d = open("guest_helpers.bin", "rb").read()
body = ",\n  ".join(", ".join("0x%02x" % b for b in d[i:i+12]) for i in range(0, len(d), 12))
open("guest_helpers_bin.h", "w").write(
    "unsigned char guest_helpers_bin[] = {\n  %s\n};\nunsigned int guest_helpers_bin_len = %d;\n" % (body, len(d)))
PY
fi
echo "bytes: $(wc -c < guest_helpers.bin) (maximo 4096)"

#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Cargar entorno y resolver dependencias desde .env
source "$SCRIPT_DIR/common_env.sh"

SO_FILE="${1:-$PROJECT_ROOT/build/android/libandroidplatformjni.so}"
BASE_APK="$PROJECT_ROOT/base_template.apk"
OUT_APK="$PROJECT_ROOT/GunBros_Android16_Dynarmic.apk"
TMP_DIR="/tmp/gunbros_package_$$"

echo "=== [GunBros Package] Packaging APK with $SO_FILE ==="
echo "  Build-Tools: $BUILD_TOOLS"
echo "  zipalign:    $ZIPALIGN"
echo "  apksigner:   $APKSIGNER"
echo "  Keystore:    $KEYSTORE"

if [[ ! -f "$SO_FILE" ]]; then
    echo "ERROR: Shared library not found at $SO_FILE" >&2
    exit 1
fi

if [[ ! -f "$BASE_APK" ]]; then
    echo "ERROR: Base template APK not found at $BASE_APK" >&2
    echo "De acuerdo con las reglas de higiene y derechos de autor, el APK base no se incluye en el repositorio." >&2
    echo "Para generarlo a partir del APK original de Gun Bros, ejecuta:" >&2
    echo "  ./scripts/make_base_apk.sh /ruta/al/GunBros_original.apk" >&2
    exit 1
fi

if [[ ! -f "$KEYSTORE" ]]; then
    echo "ERROR: Keystore not found at $KEYSTORE. Ejecuta ./setup.sh para generarlo automáticamente." >&2
    exit 1
fi

mkdir -p "$TMP_DIR/lib/arm64-v8a"
cp "$SO_FILE" "$TMP_DIR/lib/arm64-v8a/libandroidplatformjni.so"

cp "$BASE_APK" "$TMP_DIR/unaligned.apk"
(cd "$TMP_DIR" && zip -0 -u "unaligned.apk" lib/arm64-v8a/libandroidplatformjni.so)

rm -f "$OUT_APK"
"$ZIPALIGN" -p -f 4 "$TMP_DIR/unaligned.apk" "$OUT_APK"
"$APKSIGNER" sign --ks "$KEYSTORE" --ks-pass "$KEYSTORE_PASS" "$OUT_APK"
"$APKSIGNER" verify "$OUT_APK"

rm -rf "$TMP_DIR"

echo "=== [GunBros Package] Successfully generated and verified $OUT_APK ==="

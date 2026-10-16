#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

OUT_TEMPLATE="$PROJECT_ROOT/base_template.apk"

usage() {
    echo "Uso: $0 <ruta-al-APK-original-GunBros>"
    echo ""
    echo "Genera 'base_template.apk' a partir del APK original de Gun Bros (ARM32)."
    echo "El archivo resultante contiene los assets originales (incluyendo el ELF"
    echo "de 32 bits 'assets/libandroidplatformjni.so') y elimina las firmas obsoletas"
    echo "para permitir la inyección del bridge ARM64 y el firmado con apksigner."
    echo ""
    echo "Ejemplo:"
    echo "  $0 ~/Descargas/GunBros_v1.1.9.apk"
    exit 1
}

if [[ $# -lt 1 || -z "$1" ]]; then
    usage
fi

INPUT_APK="$1"

if [[ ! -f "$INPUT_APK" ]]; then
    echo "ERROR: El archivo especificado no existe: $INPUT_APK" >&2
    exit 1
fi

echo "=== [GunBros Base APK] Preparando base_template.apk ==="
echo "  APK de origen: $INPUT_APK"
echo "  Destino:       $OUT_TEMPLATE"

# Validar que sea un archivo zip/APK válido
if ! unzip -tq "$INPUT_APK" >/dev/null 2>&1; then
    echo "ERROR: El archivo proporcionado no es un APK/ZIP válido." >&2
    exit 1
fi

# Validar que contenga el binario ARM32 del juego en assets
if ! unzip -l "$INPUT_APK" | grep -q "assets/libandroidplatformjni.so"; then
    echo "ADVERTENCIA: No se encontró 'assets/libandroidplatformjni.so' en el APK." >&2
    echo "Asegúrate de que este es el APK oficial de Gun Bros para Android." >&2
fi

# Copiar a destino temporal
TMP_APK="/tmp/gunbros_base_template_$$.apk"
trap 'rm -f "$TMP_APK"' EXIT

cp -f "$INPUT_APK" "$TMP_APK"

# Eliminar firmas anteriores (META-INF/*.SF, *.RSA, *.MF) para evitar colisiones
echo "  [1/2] Limpiando firmas antiguas de META-INF..."
zip -q -d "$TMP_APK" "META-INF/*" 2>/dev/null || true

# Eliminar bibliotecas arm64-v8a previas si existieran para evitar residuos
zip -q -d "$TMP_APK" "lib/arm64-v8a/*" 2>/dev/null || true

# Mover a la raíz del proyecto
echo "  [2/2] Creando base_template.apk..."
cp -f "$TMP_APK" "$OUT_TEMPLATE"

echo "=== [GunBros Base APK] base_template.apk generado con éxito ($(ls -lh "$OUT_TEMPLATE" | awk '{print $5}')) ==="
echo "Ahora puedes compilar y empaquetar el juego ejecutando:"
echo "  ./scripts/build.sh"
echo "o empaquetar directamente con:"
echo "  ./scripts/package.sh"

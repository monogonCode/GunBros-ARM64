#!/usr/bin/env bash
# ==============================================================================
# GunBros ARM64 Bridge - Verificador e Instalador de Dependencias
# ==============================================================================
# Este script cumple una función similar a 'npm install' o 'pip install -r requirements.txt':
# 1. Configura el archivo .env si no existe a partir de .env.example.
# 2. Comprueba las dependencias del sistema (CMake, Ninja/Make, Compilador, Zip, ADB).
# 3. Comprueba y valida el Android NDK y las Build-Tools de Android SDK.
# 4. Comprueba las librerías precompiladas de Dynarmic y cabeceras de Boost.
# 5. Genera automáticamente un keystore de depuración si no existe ninguno.
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== [GunBros Setup] Comprobando Dependencias del Proyecto ===${NC}"

# 1. Asegurar archivo .env
if [[ ! -f "$PROJECT_ROOT/.env" ]]; then
    echo -e "${YELLOW}[!] No se encontró .env. Creando .env a partir de .env.example...${NC}"
    cp "$PROJECT_ROOT/.env.example" "$PROJECT_ROOT/.env"
    echo -e "${GREEN}[✓] Archivo .env generado exitosamente.${NC}"
else
    echo -e "${GREEN}[✓] Archivo .env detectado.${NC}"
fi

# Cargar entorno común
source "$SCRIPT_DIR/common_env.sh"

ALL_OK=true

# 2. Comprobar herramientas básicas del sistema
check_tool() {
    local cmd="$1"
    local name="$2"
    if which "$cmd" >/dev/null 2>&1; then
        echo -e "  ${GREEN}[✓]${NC} $name ($cmd): $(which "$cmd")"
    else
        echo -e "  ${RED}[✗]${NC} $name ($cmd) no encontrado en PATH."
        ALL_OK=false
    fi
}

echo -e "\n${BLUE}1. Herramientas del Sistema Host:${NC}"
if which "$CMAKE_BIN" >/dev/null 2>&1 || [[ -x "$CMAKE_BIN" ]]; then
    echo -e "  ${GREEN}[✓]${NC} CMake: $CMAKE_BIN"
else
    echo -e "  ${RED}[✗]${NC} CMake ($CMAKE_BIN) no encontrado. Define CMAKE_BIN en .env."
    ALL_OK=false
fi
check_tool "make" "Make (o Ninja)" || check_tool "ninja" "Ninja" || true
check_tool "zip" "Zip"
check_tool "unzip" "Unzip"
check_tool "adb" "Android Debug Bridge (ADB)" || echo -e "      ${YELLOW}(Opcional para pruebas en host, requerido para deploy en dispositivo)${NC}"

# 3. Comprobar compilador C/C++
echo -e "\n${BLUE}2. Compilador C/C++ (para pruebas locales CTest):${NC}"
if which clang >/dev/null 2>&1; then
    echo -e "  ${GREEN}[✓]${NC} Clang: $(clang --version | head -n 1)"
elif which gcc >/dev/null 2>&1; then
    echo -e "  ${GREEN}[✓]${NC} GCC: $(gcc --version | head -n 1)"
else
    echo -e "  ${RED}[✗]${NC} No se detectó compilador C/C++ (instala clang o gcc)."
    ALL_OK=false
fi

# 4. Comprobar Android NDK
echo -e "\n${BLUE}3. Android NDK (para compilación ARM64):${NC}"
if [[ -n "$NDK" && -f "$NDK/build/cmake/android.toolchain.cmake" ]]; then
    echo -e "  ${GREEN}[✓]${NC} NDK válido detectado en: $NDK"
else
    echo -e "  ${RED}[✗]${NC} NDK no encontrado en: '$NDK'"
    echo -e "      ${YELLOW}Solución: Instala Android NDK (r23c a r26d) mediante Android Studio"
    echo -e "      o descárgalo y define ANDROID_NDK_HOME en tu archivo .env.${NC}"
    ALL_OK=false
fi

# 5. Comprobar Android Build Tools (zipalign, apksigner)
echo -e "\n${BLUE}4. Android SDK Build-Tools (empaquetado y firma de APK):${NC}"
if which "$ZIPALIGN" >/dev/null 2>&1 || [[ -x "$ZIPALIGN" ]]; then
    echo -e "  ${GREEN}[✓]${NC} zipalign: $ZIPALIGN"
else
    echo -e "  ${RED}[✗]${NC} zipalign no encontrado. Define BUILD_TOOLS en tu archivo .env."
    ALL_OK=false
fi

if which "$APKSIGNER" >/dev/null 2>&1 || [[ -x "$APKSIGNER" ]]; then
    echo -e "  ${GREEN}[✓]${NC} apksigner: $APKSIGNER"
else
    echo -e "  ${RED}[✗]${NC} apksigner no encontrado. Define BUILD_TOOLS en tu archivo .env."
    ALL_OK=false
fi

# 6. Comprobar Keystore de depuración (o generarlo si falta)
echo -e "\n${BLUE}5. Keystore de Depuración:${NC}"
if [[ -f "$KEYSTORE" ]]; then
    echo -e "  ${GREEN}[✓]${NC} Keystore existente: $KEYSTORE"
else
    echo -e "  ${YELLOW}[!] Keystore no encontrado en '$KEYSTORE'. Intentando generar uno nuevo...${NC}"
    mkdir -p "$(dirname "$KEYSTORE")"
    if which keytool >/dev/null 2>&1; then
        keytool -genkey -v -keystore "$KEYSTORE" \
          -storepass android -alias androiddebugkey -keypass android \
          -keyalg RSA -keysize 2048 -validity 10000 \
          -dname "CN=Android Debug,O=Android,C=US" >/dev/null 2>&1
        echo -e "  ${GREEN}[✓]${NC} Keystore generado exitosamente en: $KEYSTORE"
    else
        echo -e "  ${RED}[✗]${NC} keytool no encontrado. Instala OpenJDK/Java para generar el keystore."
        ALL_OK=false
    fi
fi

# 7. Comprobar Dependencias de Emulación (Dynarmic y Boost)
echo -e "\n${BLUE}6. Dependencias de Emulación (Dynarmic y Boost):${NC}"
LIBDYNARMIC="$DYNARMIC_ROOT/build-arm64/src/dynarmic/libdynarmic.a"
if [[ -f "$LIBDYNARMIC" ]]; then
    echo -e "  ${GREEN}[✓]${NC} Biblioteca Dynarmic ARM64: $LIBDYNARMIC"
else
    echo -e "  ${RED}[✗]${NC} libdynarmic.a no encontrada en $LIBDYNARMIC"
    ALL_OK=false
fi

if [[ -d "$BOOST_ROOT" ]]; then
    echo -e "  ${GREEN}[✓]${NC} Cabeceras de Boost: $BOOST_ROOT"
else
    echo -e "  ${RED}[✗]${NC} Carpeta de Boost no encontrada en $BOOST_ROOT"
    ALL_OK=false
fi

# Resumen final
echo -e "\n${BLUE}==============================================================================${NC}"
if [ "$ALL_OK" = true ]; then
    echo -e "${GREEN}¡Excelente! Todas las dependencias están listas y verificadas.${NC}"
    echo -e "Para compilar el proyecto y generar el APK:"
    echo -e "  ${YELLOW}./build.sh${NC}"
    echo -e "Para ejecutar las pruebas en tu máquina:"
    echo -e "  ${YELLOW}./scripts/run_tests.sh${NC}"
else
    echo -e "${YELLOW}Se detectaron dependencias faltantes.${NC}"
    echo -e "Revisa los elementos marcados con [✗] arriba y ajusta tu archivo .env según sea necesario."
fi
echo -e "${BLUE}==============================================================================${NC}"

#!/usr/bin/env bash
# ==============================================================================
# GunBros ARM64 Bridge - Descargador e Instalador Automático de Dependencias
# ==============================================================================
# Descarga y compila automáticamente las herramientas necesarias:
# 1. CMake portátil para Linux x86_64 (si no existe en el sistema).
# 2. Android SDK Build-Tools 34.0.0 (zipalign, apksigner, aapt).
# 3. Android NDK r26d (toolchain LLVM clang, cmake toolchain, llvm-strip).
# 4. Cabeceras de Boost C++.
# 5. Dynarmic (clonado recursivo de GitHub y compilación cruzada ARM64).
# 6. Actualización automática de .env con rutas relativas portables.
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}==============================================================================${NC}"
echo -e "${BLUE}    GunBros ARM64 - Instalador Automático de Dependencias y Toolchain         ${NC}"
echo -e "${BLUE}==============================================================================${NC}"

# Cargar .env existente si existe
if [[ -f "$PROJECT_ROOT/.env" ]]; then
    set -a
    source "$PROJECT_ROOT/.env"
    set +a
elif [[ -f "$PROJECT_ROOT/.env.example" ]]; then
    cp "$PROJECT_ROOT/.env.example" "$PROJECT_ROOT/.env"
fi

source "$SCRIPT_DIR/common_env.sh"

mkdir -p "$PROJECT_ROOT/tools"
mkdir -p "$PROJECT_ROOT/third_party"

# ------------------------------------------------------------------------------
# 1. CMake portátil
# ------------------------------------------------------------------------------
echo -e "\n${CYAN}[1/5] Verificando CMake...${NC}"
NEEDS_CMAKE=false
if ! which cmake >/dev/null 2>&1 && [[ ! -x "$PROJECT_ROOT/tools/cmake/bin/cmake" ]]; then
    NEEDS_CMAKE=true
fi

if [ "$NEEDS_CMAKE" = true ]; then
    echo -e "  ${YELLOW}CMake no encontrado en el sistema. Descargando CMake 3.28.3 portátil...${NC}"
    CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-x86_64.tar.gz"
    TMP_CMAKE="/tmp/gunbros_cmake_$$.tar.gz"
    curl -# -L -o "$TMP_CMAKE" "$CMAKE_URL"
    mkdir -p "$PROJECT_ROOT/tools/cmake"
    tar -xzf "$TMP_CMAKE" -C "$PROJECT_ROOT/tools/cmake" --strip-components=1
    rm -f "$TMP_CMAKE"
    echo -e "  ${GREEN}[✓] CMake portátil instalado en tools/cmake${NC}"
    CMAKE_BIN="$PROJECT_ROOT/tools/cmake/bin/cmake"
    CTEST_BIN="$PROJECT_ROOT/tools/cmake/bin/ctest"
else
    echo -e "  ${GREEN}[✓] CMake ya está disponible: $CMAKE_BIN${NC}"
fi

# ------------------------------------------------------------------------------
# 2. Android SDK Build-Tools (zipalign, apksigner, aapt)
# ------------------------------------------------------------------------------
echo -e "\n${CYAN}[2/5] Verificando Android Build-Tools (zipalign, apksigner)...${NC}"
NEEDS_BT=false
if [[ ! -x "$ZIPALIGN" || ! -x "$APKSIGNER" ]]; then
    if [[ ! -x "$PROJECT_ROOT/tools/build-tools/34.0.0/zipalign" ]]; then
        NEEDS_BT=true
    fi
fi

if [ "$NEEDS_BT" = true ]; then
    echo -e "  ${YELLOW}Descargando Android Build-Tools 34.0.0 oficial (~61 MB)...${NC}"
    BT_URL="https://dl.google.com/android/repository/build-tools_r34-linux.zip"
    TMP_BT="/tmp/gunbros_bt_$$"
    mkdir -p "$TMP_BT"
    curl -# -L -o "$TMP_BT/bt.zip" "$BT_URL"
    unzip -q "$TMP_BT/bt.zip" -d "$TMP_BT"
    mkdir -p "$PROJECT_ROOT/tools/build-tools/34.0.0"
    cp -r "$TMP_BT"/android-14/* "$PROJECT_ROOT/tools/build-tools/34.0.0/"
    chmod +x "$PROJECT_ROOT/tools/build-tools/34.0.0/zipalign" \
             "$PROJECT_ROOT/tools/build-tools/34.0.0/apksigner" \
             "$PROJECT_ROOT/tools/build-tools/34.0.0/aapt" 2>/dev/null || true
    rm -rf "$TMP_BT"
    echo -e "  ${GREEN}[✓] Build-Tools instaladas en tools/build-tools/34.0.0${NC}"
    BUILD_TOOLS="$PROJECT_ROOT/tools/build-tools/34.0.0"
    ZIPALIGN="$BUILD_TOOLS/zipalign"
    APKSIGNER="$BUILD_TOOLS/apksigner"
else
    echo -e "  ${GREEN}[✓] Build-Tools ya disponibles.${NC}"
fi

# ------------------------------------------------------------------------------
# 3. Android NDK r26d
# ------------------------------------------------------------------------------
echo -e "\n${CYAN}[3/5] Verificando Android NDK...${NC}"
NEEDS_NDK=false
if [[ -z "$NDK" || ! -f "$NDK/build/cmake/android.toolchain.cmake" ]]; then
    NEEDS_NDK=true
fi

if [ "$NEEDS_NDK" = true ]; then
    echo -e "  ${YELLOW}NDK no encontrado. Descargando Android NDK r26d (~668 MB)...${NC}"
    NDK_URL="https://dl.google.com/android/repository/android-ndk-r26d-linux.zip"
    TMP_NDK="/tmp/gunbros_ndk_$$.zip"
    curl -# -L -o "$TMP_NDK" "$NDK_URL"
    echo -e "  ${YELLOW}Descomprimiendo NDK en tools/android-ndk-r26d...${NC}"
    unzip -q "$TMP_NDK" -d "$PROJECT_ROOT/tools"
    rm -f "$TMP_NDK"
    NDK="$PROJECT_ROOT/tools/android-ndk-r26d"
    echo -e "  ${GREEN}[✓] Android NDK r26d instalado en tools/android-ndk-r26d${NC}"
else
    echo -e "  ${GREEN}[✓] Android NDK ya disponible en: $NDK${NC}"
fi

# ------------------------------------------------------------------------------
# 4. Cabeceras de Boost
# ------------------------------------------------------------------------------
echo -e "\n${CYAN}[4/5] Verificando cabeceras de Boost...${NC}"
NEEDS_BOOST=false
if [[ -f "$PROJECT_ROOT/third_party/boost/include/boost/version.hpp" ]]; then
    BOOST_ROOT="$PROJECT_ROOT/third_party/boost/include"
elif [[ -f "$PROJECT_ROOT/third_party/boost/usr/include/boost/version.hpp" ]]; then
    BOOST_ROOT="$PROJECT_ROOT/third_party/boost/usr/include"
elif [[ -f "/usr/include/boost/version.hpp" ]]; then
    BOOST_ROOT="/usr/include"
else
    NEEDS_BOOST=true
fi

if [ "$NEEDS_BOOST" = true ]; then
    echo -e "  ${YELLOW}Descargando cabeceras de Boost 1.83.0 (~140 MB)...${NC}"
    BOOST_URL="https://archives.boost.io/release/1.83.0/source/boost_1_83_0.tar.gz"
    TMP_BOOST="/tmp/gunbros_boost_$$.tar.gz"
    curl -# -L -o "$TMP_BOOST" "$BOOST_URL"
    mkdir -p "$PROJECT_ROOT/third_party/boost/include"
    echo -e "  ${YELLOW}Extrayendo cabeceras en third_party/boost/include...${NC}"
    tar -xzf "$TMP_BOOST" -C "$PROJECT_ROOT/third_party/boost/include" --strip-components=1 "boost_1_83_0/boost"
    rm -f "$TMP_BOOST"
    BOOST_ROOT="$PROJECT_ROOT/third_party/boost/include"
    echo -e "  ${GREEN}[✓] Cabeceras de Boost listas en third_party/boost/include${NC}"
else
    echo -e "  ${GREEN}[✓] Cabeceras de Boost detectadas: $BOOST_ROOT${NC}"
fi

# ------------------------------------------------------------------------------
# 5. Dynarmic (Clonado y Compilación ARM64)
# ------------------------------------------------------------------------------
echo -e "\n${CYAN}[5/5] Verificando Dynarmic JIT (bibliotecas ARM64)...${NC}"
DYNARMIC_LIB="$PROJECT_ROOT/third_party/dynarmic/build-arm64/src/dynarmic/libdynarmic.a"
if [[ ! -d "$PROJECT_ROOT/third_party/dynarmic" ]]; then
    echo -e "  ${YELLOW}Clonando Dynarmic desde GitHub...${NC}"
    git clone --depth 1 --recurse-submodules https://github.com/lioncash/dynarmic.git "$PROJECT_ROOT/third_party/dynarmic"
fi

if [[ ! -f "$DYNARMIC_LIB" ]]; then
    echo -e "  ${YELLOW}Compilando bibliotecas estáticas de Dynarmic para Android ARM64...${NC}"
    rm -rf "$PROJECT_ROOT/third_party/dynarmic/build-arm64"
    mkdir -p "$PROJECT_ROOT/third_party/dynarmic/build-arm64"
    "$CMAKE_BIN" -B "$PROJECT_ROOT/third_party/dynarmic/build-arm64" -S "$PROJECT_ROOT/third_party/dynarmic" \
      -DCMAKE_TOOLCHAIN_FILE="$NDK/build/cmake/android.toolchain.cmake" \
      -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=android-30 \
      -DCMAKE_BUILD_TYPE=Release \
      -DDYNARMIC_FRONTENDS=A32 \
      -DDYNARMIC_TESTS=OFF \
      -DDYNARMIC_USE_LLVM=OFF \
      -DBoost_INCLUDE_DIR="$BOOST_ROOT" \
      -DBoost_ROOT="$BOOST_ROOT" \
      -DBOOST_ROOT="$BOOST_ROOT"

    "$CMAKE_BIN" --build "$PROJECT_ROOT/third_party/dynarmic/build-arm64" --target dynarmic fmt mcl -j"$(nproc)"
    echo -e "  ${GREEN}[✓] Dynarmic ARM64 compilado exitosamente.${NC}"
else
    echo -e "  ${GREEN}[✓] Dynarmic ARM64 ya está compilado.${NC}"
fi

# ------------------------------------------------------------------------------
# 6. Keystore de depuración
# ------------------------------------------------------------------------------
if [[ ! -f "$PROJECT_ROOT/third_party/keystore/debug.keystore" ]]; then
    mkdir -p "$PROJECT_ROOT/third_party/keystore"
    if which keytool >/dev/null 2>&1; then
        keytool -genkey -v -keystore "$PROJECT_ROOT/third_party/keystore/debug.keystore" \
          -storepass android -alias androiddebugkey -keypass android \
          -keyalg RSA -keysize 2048 -validity 10000 \
          -dname "CN=Android Debug,O=Android,C=US" >/dev/null 2>&1
        echo -e "  ${GREEN}[✓] Keystore generado en third_party/keystore/debug.keystore${NC}"
    fi
fi

# ------------------------------------------------------------------------------
# 7. Actualizar archivo .env con rutas relativas
# ------------------------------------------------------------------------------
echo -e "\n${CYAN}Actualizando configuración en .env...${NC}"
ENV_FILE="$PROJECT_ROOT/.env"

# Helper para sustituir o añadir variable
set_env_var() {
    local key="$1"
    local val="$2"
    if grep -q "^${key}=" "$ENV_FILE" 2>/dev/null; then
        sed -i "s|^${key}=.*|${key}=\"${val}\"|" "$ENV_FILE"
    else
        echo "${key}=\"${val}\"" >> "$ENV_FILE"
    fi
}

# Resolver rutas relativas para el .env
rel_path() {
    local target="$1"
    if [[ "$target" = "$PROJECT_ROOT"/* ]]; then
        echo "./${target#$PROJECT_ROOT/}"
    else
        echo "$target"
    fi
}

set_env_var "ANDROID_NDK_HOME" "$(rel_path "$NDK")"
set_env_var "NDK" "$(rel_path "$NDK")"
set_env_var "BUILD_TOOLS" "$(rel_path "$BUILD_TOOLS")"
set_env_var "CMAKE_BIN" "$(rel_path "$CMAKE_BIN")"
set_env_var "CTEST_BIN" "$(rel_path "$CTEST_BIN")"
set_env_var "DYNARMIC_ROOT" "$(rel_path "$PROJECT_ROOT/third_party/dynarmic")"
set_env_var "BOOST_ROOT" "$(rel_path "$BOOST_ROOT")"
set_env_var "KEYSTORE" "./third_party/keystore/debug.keystore"
set_env_var "KEYSTORE_PASS" "pass:android"
set_env_var "ADB_INSTALL_FLAGS" "--no-incremental --bypass-low-target-sdk-block -r -d"

echo -e "${GREEN}[✓] Archivo .env configurado con éxito.${NC}"
echo -e "\n${GREEN}==============================================================================${NC}"
echo -e "${GREEN}¡Todas las herramientas y dependencias han sido instaladas correctamente!   ${NC}"
echo -e "${GREEN}Ahora puedes ejecutar:${NC}"
echo -e "  ${YELLOW}./setup.sh${NC}            (para verificar dependencias)"
echo -e "  ${YELLOW}./scripts/run_tests.sh${NC}  (para ejecutar pruebas unitarias)"
echo -e "  ${YELLOW}./build.sh${NC}            (para compilar y generar el APK)"
echo -e "${GREEN}==============================================================================${NC}"

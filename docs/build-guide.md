# Guía de Compilación: GunBros ARM64 Bridge

Esta guía describe cómo compilar el proyecto tanto en modo local (para ejecutar las pruebas automatizadas en tu ordenador) como en modo cruzado para Android (generando el APK final de 64 bits instalable en cualquier dispositivo).

---

## 1. Requisitos Previos

### 1.1. Sistema Operativo
- **Linux**: Ubuntu 20.04+, Debian 11+, Fedora 36+, Arch Linux o distribuciones equivalentes.
- **Windows**: Compatible mediante **WSL2** (Windows Subsystem for Linux con Ubuntu 22.04+).
- **macOS**: Compatible con herramientas de desarrollo de línea de comandos.

### 1.2. Herramientas del Sistema Host
- **Compilador C/C++**: GCC 10+ o Clang 12+ (compatible con C99 y C++20).
- **CMake**: Versión 3.20 o superior.
- **Ninja o Make**: Sistema de construcción por lotes.
- **Zip / Unzip**: Para manipulación de paquetes APK.

### 1.3. Herramientas de Desarrollo Android
- **Android NDK**: NDK versión `r23c` a `r26d` (se recomienda `r26d`).
- **Android SDK Build-Tools**: Versión `30.0.0` o superior (incluye `zipalign` y `apksigner`).
- **Dependencias Externas**:
  - Biblioteca **Dynarmic** compilada para arquitectura `arm64-v8a` (`libdynarmic.a`, `libfmt.a`, `libmcl.a`).
  - Cabeceras de **Boost** (requeridas por la interfaz de Dynarmic).
- **Keystore de Depuración**: Keystore estándar de Android (`~/.android/debug.keystore`).

---

## 2. Configuración del Entorno de Trabajo

El proyecto utiliza un sistema de configuración mediante `.env` (similar a herramientas como Node.js o Python) para que cualquier persona pueda ejecutarlo sin modificar archivos internos.

### 2.1. Verificación e Instalación Automática con `./setup.sh`
La forma más rápida de preparar el entorno es ejecutar:
```bash
./setup.sh
```
Si se detecta que faltan dependencias (CMake portátil, Android NDK, Android Build-Tools, Boost o Dynarmic), el script te preguntará interactivamente si deseas descargarlas y compilarlas automáticamente.

También puedes forzar la descarga y configuración desatendida directamente con:
```bash
./setup.sh --download
```
Este proceso automatizado:
1. Crea tu archivo `.env` automáticamente si no existe.
2. Descarga CMake portátil (si no está en el sistema).
3. Descarga Android SDK Build-Tools 34.0.0 (`zipalign`, `apksigner`, `aapt`).
4. Descarga Android NDK r26d oficial de Google.
5. Descarga las cabeceras de Boost C++.
6. Clona Dynarmic desde GitHub y compila sus bibliotecas estáticas para arquitectura `arm64-v8a`.
7. Genera un keystore de depuración (`debug.keystore`) si no tienes uno.
8. Configura las rutas relativas en `.env` para que todo quede listo para compilar.

### 2.2. Personalización Manual mediante `.env`
Si deseas personalizar rutas específicas para tu máquina, edita `.env`:
```bash
cp .env.example .env
```
Ejemplo de variables disponibles:
```bash
# Android NDK y SDK
ANDROID_NDK_HOME="./tools/android-ndk-r26d" # o $HOME/Android/Sdk/ndk/26.1.10909125
BUILD_TOOLS="./tools/build-tools/34.0.0"     # o $ANDROID_HOME/build-tools/34.0.0

# Herramientas
CMAKE_BIN="cmake"
CTEST_BIN="ctest"

# Dependencias (resueltas automáticamente en third_party/)
DYNARMIC_ROOT="./third_party/dynarmic"
BOOST_ROOT="./third_party/boost/usr/include"
```
> **Nota**: Las rutas relativas que comienzan por `./` se resuelven automáticamente respecto a la raíz del proyecto.


---

## 3. Inicio Rápido (Scripts Automatizados)

### 3.0. Preparación del APK Base (`base_template.apk`)
En conformidad con las reglas de derechos de autor e higiene del repositorio, los archivos APK originales y assets del juego **no están incluidos** en el repositorio.

Antes del primer empaquetado, genera `base_template.apk` a partir de un APK original de Gun Bros v1.1.9 (ARM32) proporcionado por el usuario:
```bash
./scripts/make_base_apk.sh /ruta/al/GunBros_original.apk
```
Este script:
1. Verifica la presencia de los assets esenciales (`assets/libandroidplatformjni.so`, etc.).
2. Elimina firmas criptográficas obsoletas de `META-INF/` para permitir una firma limpia con `apksigner`.
3. Prepara la estructura para la posterior inyección de la biblioteca ARM64.

### 3.1. Compilar el APK Completo para Android
Desde el directorio raíz del repositorio:
```bash
./build.sh
```
Este comando ejecuta automáticamente:
1. Configuración de CMake para arquitectura `arm64-v8a` con target de API Android 30+.
2. Compilación de todos los módulos C/C++ en `src/`.
3. Enlace con la biblioteca de Dynarmic y librerías del sistema Android (`libEGL`, `libGLESv1_CM`, `libaaudio`, `liblog`).
4. Reducción de tamaño del binario mediante `llvm-strip`.
5. Inyección de `libandroidplatformjni.so` en `base_template.apk`.
6. Alineación de 4 bytes (`zipalign`) y firma criptográfica con `apksigner`.

El archivo resultante será:
```
GunBros_Android16_Dynarmic.apk
```

### 3.2. Ejecutar la Suite de Pruebas en el Host
Para verificar el correcto funcionamiento del sistema de archivos, la memoria y los búferes de audio sin necesidad de conectar un teléfono:
```bash
./scripts/run_tests.sh
```

---

## 4. Compilación Manual con CMake

Si prefieres tener un control granular sobre cada paso del proceso:

### 4.1. Pruebas Unitarias en el Host (Modo Debug)
```bash
# 1. Crear directorio de construcción
mkdir -p build/host

# 2. Configurar proyecto con soporte de pruebas activo
cmake -B build/host -S . \
  -DCMAKE_BUILD_TYPE=Debug \
  -DBUILD_TESTING=ON

# 3. Compilar los ejecutables de prueba
cmake --build build/host -j$(nproc)

# 4. Ejecutar todas las pruebas mediante CTest
ctest --test-dir build/host --output-on-failure --verbose
```

### 4.2. Biblioteca Compartida de Android (`libandroidplatformjni.so`)
```bash
# 1. Crear directorio de construcción
mkdir -p build/android

# 2. Configurar compilación cruzada con el NDK
cmake -B build/android -S . \
  -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake" \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_PLATFORM=android-30 \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TESTING=OFF \
  -DDYNARMIC_ROOT="$DYNARMIC_ROOT" \
  -DBOOST_ROOT="$BOOST_ROOT"

# 3. Compilar el target compartido
cmake --build build/android --target androidplatformjni -j$(nproc)

# 4. Reducir símbolos innecesarios
$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip \
  --strip-unneeded build/android/libandroidplatformjni.so
```

---

## 5. Empaquetado y Firma Manual del APK

Si has recompilado únicamente el archivo `.so` y deseas empaquetarlo en el APK:
```bash
./scripts/package.sh build/android/libandroidplatformjni.so
```

---

## 6. Despliegue e Instalación en Dispositivo Físico o Emulador

Para instalar y ejecutar la aplicación en un dispositivo conectado mediante USB con depuración ADB activada:
```bash
./scripts/deploy.sh
```

### Notas Importantes para Dispositivos con Android 14, 15 y 16:
Android 14+ bloquea por defecto la instalación de aplicaciones cuyo `targetSdkVersion` sea inferior a 23. Para permitir la instalación en estos sistemas operativos modernos, el script utiliza el parámetro especial de ADB:
```bash
adb install --no-incremental --bypass-low-target-sdk-block -r -d GunBros_Android16_Dynarmic.apk
```
Tras la instalación, se asignan automáticamente los permisos de almacenamiento necesarios para permitir que la capa de compatibilidad acceda a los recursos del juego.

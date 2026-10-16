# GunBros ARM64 Bridge

Un puente de compatibilidad y emulación en tiempo real (JIT) de alto rendimiento que permite ejecutar el clásico juego de acción en 3D **GunBros** (desarrollado originalmente por Glu Mobile para arquitecturas ARM de 32 bits / `armeabi-v7a`) en dispositivos Android modernos que solo admiten aplicaciones de 64 bits (Android 14, 15 y 16 / procesadores ARMv9).

---

**GunBros ARM64 Bridge** permite ejecutar el juego de Gun Bros en telefonos con veriones actuales de android 64bits combinando:
- **Dynarmic**: Recompilación dinámica JIT de código ARM32 a ARM64 en tiempo real a 60 FPS estables.
- **Capa HLE (High-Level Emulation)**: Intercepción de 178 llamadas al sistema (Bionic libc, libm, libz, POSIX y OpenGL ES 1.1 CM).
- **Parches en Caliente**: Anulación de llamadas a servidores antiguos cerrados (Glu y GameSpy), habilitación de multitáctil dual-stick contemporáneo y adaptación visual a pantallas ultrapanorámicas (20:9 o 21:9).
- **Persistencia y Scoped Storage**: Emulación de un sistema de archivos seguro adaptado a las políticas de almacenamiento modernas de Android.

---

## 🏗️ Arquitectura del Repositorio

El proyecto se encuentra estrictamente desacoplado por responsabilidades:

```text
gunbros/
├── CMakeLists.txt                # Configuración CMake unificada (Android NDK & Host Testing)
├── build.sh                      # Script rápido de compilación y empaquetado del APK
├── base_template.apk             # Plantilla APK base de GunBros
│
├── docs/                         # Documentación técnica completa y guías
│   ├── architecture.md           # Diagrama de subsistemas, memoria virtual y concurrencia
│   ├── build-guide.md            # Guía detallada de compilación host y cross-compile NDK
│   ├── compatibility.md          # Parches binarios (A-J), HLE y máquina virtual JNI sintética
│   ├── filesystem.md             # Mecánica de I/O, esquemas virtuales Glu y estado del guardado
│   ├── debugging.md              # Depuración con Logcat, watchdog y volcado de registros
│   └── testing.md                # Metodología de pruebas y catálogo de suites CTest
│
├── include/gunbros/              # Interfaces públicas C/C++ tipadas y modulares
│   ├── bridge/                   # Ciclo de vida, render loop y exportaciones JNI
│   ├── emulator/                 # Dynarmic JIT backend, memoria virtual, ELF loader, HLE
│   ├── filesystem/               # Mapeo de rutas, handles virtuales, I/O con autoflush
│   ├── platform/                 # AAudio stream, EGL window, letterboxing y ring buffer PCM
│   └── compatibility/            # Parches binarios de motor y JVM sintética
│
├── src/                          # Implementaciones de cada subsistema (C99 & C++20)
│   ├── bridge/                   # bridge_core.c, jni_exports.c
│   ├── emulator/                 # dynarmic_backend.cpp, elf_loader.c, guest_memory.c, hle_dispatcher.c
│   ├── filesystem/               # path_mapper.c, file_handles.c, file_operations.c, directory_operations.c, filesystem_logger.c
│   ├── platform/                 # android_window.c, android_audio.c, pcm_ring.c, jni_env_helper.c
│   └── compatibility/            # game_patches.c, jni_virtual_machine.c
│
├── tests/                        # Pruebas automatizadas en host (100% pass rate en CTest)
│   ├── filesystem/               # test_path_mapper, test_file_operations, test_persistence
│   ├── platform/                 # test_pcm_ring
│   └── emulator/                 # test_guest_memory
│
├── scripts/                      # Scripts portables de automatización y CI
│   ├── build.sh                  # Compilación cruzada con Android NDK y generación de librerías
│   ├── package.sh                # Inyección en APK, zipalign y firma con apksigner
│   ├── deploy.sh                 # Instalación en dispositivo físico/emulador vía ADB
│   ├── run_tests.sh              # Compilación y ejecución de CTest en host
│   └── collect-logs.sh           # Captura continua y filtrada de logs en archivo
│
└── legacy/                       # Archivo histórico del código previo para auditoría
```

---

## 🚀 Inicio Rápido

### 1. Configurar Entorno y Dependencias
Verifica las herramientas de tu sistema y genera el archivo `.env` automáticamente:
```bash
./setup.sh
```

### 2. Compilar el APK Completo para Android
Compila la biblioteca nativa `libandroidplatformjni.so`, la inyecta en el APK base, realiza la alineación de 4 bytes (`zipalign`) y la firma criptográfica:
```bash
./build.sh
```
El archivo final generado es: `GunBros_Android16_Dynarmic.apk`.

### 3. Ejecutar la Suite de Pruebas Automatizadas (Host)
Compila y ejecuta las 5 suites de prueba mediante **CTest** en tu ordenador (sin requerir teléfono Android):
```bash
./scripts/run_tests.sh
```

### 4. Instalar y Ejecutar en tu Dispositivo Android
Conecta tu dispositivo Android mediante USB con depuración ADB activa:
```bash
./scripts/deploy.sh
```
*Nota*: El script aplica automáticamente el flag `--bypass-low-target-sdk-block` requerido por Android 14, 15 y 16 para aplicaciones con target SDK heredado.

### 5. Ver Registros y Diagnóstico en Vivo
```bash
./scripts/collect-logs.sh
```


---

## 💾 Estado del Sistema de Archivos y Guardado de Progreso

Se ha completado una auditoría profunda de la persistencia de datos:
- **E/S POSIX y Scoped Storage**: La normalización de rutas a carpetas privadas de la aplicación, el aislamiento en descriptores de archivo virtuales (`1` al `64`), el vaciado automático de búferes (`fflush`) y las operaciones atómicas de renombrado funcionan al 100% sin errores de kernel.
- **Investigación Pendiente de la Lógica del Motor**: Aunque los archivos (`prefs.dat`, `savegame.dat`, `-1_1000`..`-1_1019`) se escriben y conservan físicamente en el disco, la lógica interna de GunBros (`CSaveGameMgr::Read`) actualmente reinicia el progreso visible del jugador tras reiniciar por completo la aplicación. 
- Para conocer las hipótesis técnicas (cifrado dependiente del ID de dispositivo, checksums de perfiles, o validación de atributos), consulta el documento detallado en [docs/filesystem.md](docs/filesystem.md).

---

## 📚 Índice de Documentación Técnica

Para comprender a fondo cada aspecto del proyecto, consulta las guías dedicadas en la carpeta `docs/`:

1. [**Arquitectura del Sistema** (`docs/architecture.md`)](docs/architecture.md): Diagrama de subsistemas, mapa de memoria virtual de 32 bits y modelo de sincronización multihilo.
2. [**Sistema de Archivos y Guardado** (`docs/filesystem.md`)](docs/filesystem.md): Scoped Storage, esquemas virtuales Glu (`data:`, `temp:`), guardado atómico y análisis de persistencia.
3. [**Capa de Compatibilidad y HLE** (`docs/compatibility.md`)](docs/compatibility.md): Parches binarios en caliente (Patches A-J), JVM sintética y catálogo de llamadas interceptadas.
4. [**Guía de Compilación** (`docs/build-guide.md`)](docs/build-guide.md): Requisitos previos, variables de entorno (`$ANDROID_NDK_HOME`), compilación manual paso a paso y firma de APKs.
5. [**Guía de Pruebas** (`docs/testing.md`)](docs/testing.md): Metodología de pruebas unitarias, prueba de persistencia entre procesos y cómo añadir nuevos tests.
6. [**Guía de Depuración** (`docs/debugging.md`)](docs/debugging.md): Etiquetas de Logcat, volcado del hilo supervisor (Watchdog) y solución de problemas comunes.

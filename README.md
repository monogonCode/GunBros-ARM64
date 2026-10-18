# GunBros ARM64 Bridge

Un puente de compatibilidad y emulación en tiempo real (JIT) de alto rendimiento que permite ejecutar el clásico juego de acción en 3D **GunBros** (desarrollado originalmente por Glu Mobile para arquitecturas ARM de 32 bits / `armeabi-v7a`) en dispositivos Android modernos que solo admiten aplicaciones de 64 bits (Android 14, 15 y 16 / procesadores ARMv9).

> [!IMPORTANT]
> **Aviso de Propiedad Intelectual**: Este repositorio **NO incluye ni distribuye el archivo APK, assets gráficos/sonoros ni el código original del juego Gun Bros** (propiedad de Glu Mobile / EA). El usuario debe aportar su propia copia legítima del APK original para generar la plantilla base con `scripts/make_base_apk.sh`.

---

**GunBros ARM64 Bridge** permite ejecutar el juego de Gun Bros en teléfonos con versiones actuales de Android de 64 bits combinando:
- **Dynarmic**: Recompilación dinámica JIT de código ARM32 a ARM64 en tiempo real a 60 FPS estables.
- **Capa HLE Modular**: Intercepción y despacho de llamadas al sistema (Bionic libc, libm, libz, POSIX y OpenGL ES 1.1 CM) dividida en módulos temáticos (`src/hle/`).
- **Parches en Caliente Controlados**: Tabla declarativa de parches binarios con verificación opcional de opcodes previos y captura bajo `BRIDGE_DEBUG` para eludir servidores antiguos cerrados (Glu y GameSpy) y adaptar la orientación de armas y esqueleto.
- **Persistencia Robusta**: Capa de sistema de archivos compatible con Bionic ARM32, E/S de 32 bits con signo y trazado de diagnósticos.

---

## Arquitectura del Repositorio

El proyecto se encuentra estrictamente desacoplado por responsabilidades:

```text
gunbros/
├── CMakeLists.txt                # Configuración CMake unificada (Android NDK & Host Testing)
├── build.sh                      # Script rápido de compilación y empaquetado del APK
├── LICENSE                       # Términos de licencia y avisos de derechos de autor
│
├── docs/                         # Documentación técnica completa y guías
│   ├── architecture.md           # Diagrama de subsistemas, memoria virtual y concurrencia
│   ├── build-guide.md            # Guía de compilación host, make_base_apk y cross-compile NDK
│   ├── compatibility.md          # Parches binarios (A-J), HLE y máquina virtual JNI sintética
│   ├── filesystem.md             # Mecánica de I/O, esquemas virtuales Glu y layout stat Bionic
│   ├── save-debugging.md         # Protocolo de diagnóstico paso a paso de persistencia
│   ├── debugging.md              # Depuración con Logcat, watchdog y volcado de registros
│   └── testing.md                # Metodología de pruebas y catálogo de suites CTest
│
├── include/gunbros/              # Interfaces públicas C/C++ tipadas y modulares
│   ├── bridge/                   # Ciclo de vida, render loop y exportaciones JNI
│   ├── emulator/                 # Dynarmic JIT backend, memoria virtual, ELF loader, dispatcher
│   ├── hle/                      # Declaraciones públicas de manejadores libc HLE
│   ├── filesystem/               # Mapeo de rutas, handles virtuales, I/O con autoflush
│   ├── platform/                 # AAudio stream, EGL window, letterboxing y ring buffer PCM
│   └── compatibility/            # Parches binarios, hooks de juego, símbolos guest y JVM sintética
│
├── src/                          # Implementaciones de cada subsistema (C99 & C++20)
│   ├── bridge/                   # bridge_core.c, jni_exports.c
│   ├── emulator/                 # dynarmic_backend.cpp, elf_loader.c, guest_memory.c
│   ├── hle/                      # libc_string.c, libc_time.c, libc_stdio.c, net_stubs.c, gles1.c, hle_table.c
│   ├── filesystem/               # path_mapper.c, file_handles.c, file_operations.c, directory_operations.c, filesystem_logger.c
│   ├── platform/                 # android_window.c, android_audio.c, pcm_ring.c, jni_env_helper.c
│   └── compatibility/            # game_patches.c, game_hooks.c, jni_virtual_machine.c, jni_methods.c, jni_audio.c
│
├── tests/                        # Pruebas automatizadas en host (100% pass rate en CTest)
│   ├── filesystem/               # test_path_mapper, test_file_operations, test_host_io_persistence
│   ├── platform/                 # test_pcm_ring
│   ├── emulator/                 # test_guest_memory
│   ├── test_hle_libc.c           # Pruebas de fseek negativo, time 4 bytes, stat bionic y sscanf
│   └── golden/                   # golden_save_runner.c y documentación de volcados reales
│
├── scripts/                      # Scripts portables de automatización y CI
│   ├── make_base_apk.sh          # Generación de base_template.apk desde el APK original
│   ├── build.sh                  # Compilación cruzada con Android NDK (genera build/android/)
│   ├── package.sh                # Inyección de so en APK, zipalign y firma con apksigner
│   ├── deploy.sh                 # Instalación en dispositivo físico/emulador vía ADB
│   ├── run_tests.sh              # Compilación y ejecución de CTest en host con aislamiento
│   └── collect-logs.sh           # Captura continua y filtrada de logs (GunBrosARM64, GunBrosFS)
```

> **Nota de archivo**: El código histórico previo ha sido purgado del árbol de trabajo y se conserva íntegramente en la etiqueta Git `legacy-archive`.

---

## Inicio Rápido

### 1. Configurar Entorno y Dependencias
Verifica las herramientas de tu sistema y descarga/configura dependencias faltantes automáticamente:
```bash
./setup.sh
# O para descarga automática desatendida de NDK, Build-Tools, Boost y Dynarmic:
./setup.sh --download
```

### 2. Generar la Plantilla Base (`base_template.apk`)
Aporta tu copia legítima del APK original de Gun Bros v1.1.9 (ARM32):
```bash
./scripts/make_base_apk.sh /ruta/al/GunBros_original.apk
```

### 3. Compilar el APK Completo para Android
Compila la biblioteca nativa en `build/android/libandroidplatformjni.so`, la inyecta en el APK base, realiza la alineación de 4 bytes (`zipalign`) y la firma criptográfica:
```bash
./build.sh
```
El archivo final generado es: `GunBros_Android16_Dynarmic.apk`.

### 4. Ejecutar la Suite de Pruebas Automatizadas (Host)
Compila y ejecuta las 7 suites de prueba mediante **CTest** en tu ordenador (sin requerir teléfono Android):
```bash
./scripts/run_tests.sh
```

### 5. Instalar y Ejecutar en tu Dispositivo Android
Conecta tu dispositivo Android mediante USB con depuración ADB activa:
```bash
./scripts/deploy.sh
```
*Nota*: El script aplica automáticamente el flag `--bypass-low-target-sdk-block` requerido por Android 14, 15 y 16 para aplicaciones con target SDK heredado.

### 6. Ver Registros y Diagnóstico en Vivo
```bash
./scripts/collect-logs.sh
```

---

## Estado del Sistema de Archivos y Persistencia

Tras la auditoría y corrección en la revisión de octubre de 2026, se corrigieron los siguientes defectos críticos en la capa HLE de archivos y memoria:

1. **Corrección de signo en `h_fseek`**: Se corrigió el casteo que transformaba offsets negativos del guest (utilizados habitualmente con `SEEK_END` o `SEEK_CUR`) en enteros positivos de 64 bits (~4 GB), provocando lecturas vacías posteriores.
2. **Aislamiento de ancho en `h_time`**: Se corrigió la escritura de `time_t` de 64 bits del host que desbordaba sobre la memoria contigua del guest de 32 bits. Ahora se escribe estrictamente un `uint32_t`.
3. **Layout de `struct stat` idéntico a Bionic ARM32**: Se implementó el mapeo exacto de 104 bytes de Bionic (`st_ino@12`, `st_mode@16`, `st_nlink@20`, `st_uid@24`, `st_gid@28`, `st_size@48` [8 bytes], `st_blksize@56`, `st_blocks@64` [8 bytes], `st_atime@72`, `st_mtime@80`, `st_ctime@88`), evitando desalineaciones con `memcpy`.
4. **Normalización de anchos en `h_sscanf`**: Se normalizan los especificadores `%ld`/`%lu`/`%lx` a tipos de 4 bytes para evitar que el `sscanf` del host de 64 bits sobrescriba enteros adyacentes del guest, y se soportan argumentos ilimitados sobre la pila.
5. **Stubs informativos**: Se eliminó el fallo silencioso de funciones no implementadas (`fprintf`, `fdopen`, `mkstemp`, `close`, `dup`, `ioctl`, `puts`), advirtiendo en el log con el valor de `LR` del guest y alertando si flujos distintos de `stdout`/`stderr` sufren escrituras perdidas.
6. **Trazado de guardado en `BRIDGE_DEBUG`**: Se trazan todas las aperturas, lecturas, desplazamientos y cierres de archivos de guardado (`savegame.dat`, `prefs.dat`, etc.), volcando un volcado hexadecimal de los primeros 64 bytes al cerrarse archivos en modo escritura.
7. **Protocolo de diagnóstico**: Para comprobar si una sesión de juego conserva el progreso o es reiniciada por la lógica interna, sigue el protocolo detallado en [docs/save-debugging.md](docs/save-debugging.md).

---

## Índice de Documentación Técnica

Para comprender a fondo cada aspecto del proyecto, consulta las guías dedicadas en la carpeta `docs/`:

1. [**Arquitectura del Sistema** (`docs/architecture.md`)](docs/architecture.md): Diagrama de subsistemas, modularización HLE, mapa de memoria virtual y modelo de sincronización multihilo.
2. [**Sistema de Archivos y Persistencia** (`docs/filesystem.md`)](docs/filesystem.md): Scoped Storage, esquemas virtuales Glu (`data:`, `temp:`), guardado atómico y layout `stat` Bionic ARM32.
3. [**Protocolo de Diagnóstico de Guardado** (`docs/save-debugging.md`)](docs/save-debugging.md): Protocolo paso a paso para diagnosticar lecturas, sobrescrituras y hexdumps entre sesiones.
4. [**Capa de Compatibilidad y HLE** (`docs/compatibility.md`)](docs/compatibility.md): Parches binarios tabla-driven, hooks de personajes, JVM sintética y métodos JNI desacoplados.
5. [**Guía de Compilación** (`docs/build-guide.md`)](docs/build-guide.md): Requisitos previos, generación de `base_template.apk`, compilación NDK y empaquetado.
6. [**Guía de Pruebas** (`docs/testing.md`)](docs/testing.md): Metodología de pruebas unitarias, suite de pruebas HLE libc y runner de guardados reales.
7. [**Guía de Depuración** (`docs/debugging.md`)](docs/debugging.md): Etiquetas unificadas de Logcat (`GunBrosARM64`, `GunBrosFS`), volcado del Watchdog y solución de problemas.

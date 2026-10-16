# Arquitectura del Sistema: GunBros ARM64 Bridge

## 1. Visión General y Propósito del Proyecto

**GunBros** es un clásico juego de acción en tercera persona ("dual-stick shooter") desarrollado originalmente por **Glu Mobile** para Android 2.x–4.x (arquitectura ARMv7 de 32 bits, `armeabi-v7a`).

En las generaciones recientes de procesadores móviles (núcleos ARM Cortex basados en ARMv9, presentes en dispositivos con Android 14, 15 y 16), los fabricantes y el sistema operativo han eliminado por completo el soporte de ejecución en hardware para instrucciones de 32 bits (AArch32). Al intentar ejecutar una aplicación de 32 bits en estos dispositivos, el sistema operativo falla inmediatamente porque el microprocesador solo admite el conjunto de instrucciones de 64 bits (AArch64).

El objetivo de **GunBros ARM64 Bridge** es permitir que GunBros se ejecute de forma nativa, fluida (60 FPS estables) y segura en cualquier dispositivo Android moderno de 64 bits, sin necesidad del código fuente original del juego, utilizando:
1. **Dynarmic**: Un motor de recompilación dinámica (JIT) de alto rendimiento que traduce bloques de código máquina ARM32 a instrucciones ARM64 en tiempo real.
2. **Capa HLE (High-Level Emulation)**: Intercepta las llamadas a la biblioteca de C (Bionic libc/libm), sistema de archivos POSIX y gráficos OpenGL ES 1.1, ejecutándolas a velocidad nativa de 64 bits en el dispositivo anfitrión.
3. **Capa de Compatibilidad y Parches Binarios**: Corrige fallos históricos del juego (bloqueos por servidores cerrados, problemas táctiles y de aspecto visual).
4. **Capa de Plataforma y Audio**: Gestiona la ventana EGL, el escalado visual con bandas negras (*letterboxing*) y el audio de baja latencia mediante AAudio.

---

## 2. Diagrama de Subsistemas

El proyecto está diseñado bajo el principio de **responsabilidad única**, separando estrictamente la emulación, la interoperabilidad con Android y el sistema de archivos:

```
+-------------------------------------------------------------------------------+
|                            Puntos de Entrada JNI                              |
|                       (src/bridge/jni_exports.c)                              |
|               Interactúa con la Activity Java / Android OS                    |
+-------------------------------------------------------------------------------+
                                        |
+---------------------------------------v---------------------------------------+
|                                  Bridge Core                                  |
|            (src/bridge/bridge_core.c: ciclo de vida, render loop)             |
+-------------------+-------------------+-------------------+-------------------+
                    |                   |                   |
+-------------------v---+   +-----------v-------+   +-------v-------------------+
|     Emulador Core     |   |   Capa Plataforma |   | Capa de Compatibilidad    |
|                       |   |                   |   |                           |
| - dynarmic_backend    |   | - android_window  |   | - game_patches            |
| - elf_loader          |   | - android_audio   |   | - jni_virtual_machine     |
| - guest_memory        |   | - pcm_ring        |   |                           |
| - hle_dispatcher      |   | - jni_env_helper  |   |                           |
+-----------------------+   +-------------------+   +---------------------------+
                    |                   |
+-------------------v-------------------v---------------------------------------+
|                            Capa de Sistema de Archivos                        |
|                                                                               |
| - path_mapper: Redirección de rutas heredadas a Scoped Storage moderno        |
| - file_handles: Tabla virtual de descriptores aislada del host (1..64)        |
| - file_operations: fopen, fread, fwrite (autoflush), fseek, rename, remove    |
| - directory_operations: opendir, readdir, closedir, mkdir, rmdir              |
| - filesystem_logger: Auditoría y diagnóstico de I/O en Logcat (tag GunBrosFS) |
+-------------------------------------------------------------------------------+
```

---

## 3. Descripción Detallada de Subsistemas

### 3.1. Subsistema Bridge (`include/gunbros/bridge/`, `src/bridge/`)
- **`bridge_core`**: Coordina el ciclo de vida de la aplicación (`bridge_init`, `bridge_start`, `bridge_step_frame`, `bridge_pause`, `bridge_resume`, `bridge_destroy`). Gestiona el cerrojo global del emulador (`g_emu_mutex`), despacha eventos táctiles acumulados en la cola de entrada y ejecuta la función principal de renderizado del motor invitado (`nativeRender`).
- **`jni_exports`**: Define las funciones JNI nativas requeridas por las clases Java históricas de Glu Mobile (`GluPlatformActivityJNI`, `GWallet`, etc.). Su única responsabilidad es recibir las llamadas de Android, verificar los tipos de datos y reenviarlas a los módulos nativos correspondientes sin incrustar lógica de negocio.

### 3.2. Subsistema de Emulación (`include/gunbros/emulator/`, `src/emulator/`)
- **`dynarmic_backend`**: Envoltorio C++20 sobre el motor JIT Dynarmic. Configura las tablas de páginas de memoria, trampas de interrupción por software (SVC), registros de coprocesador y cachés de bloques compilados. Ejecuta el código ARM32 invitado a partir de una dirección de memoria dada.
- **`elf_loader`**: Analiza el binario ELF de 32 bits `libandroidplatform.so`. Lee las cabeceras de programa (`PT_LOAD`), mapea los segmentos en el espacio de memoria emulada, resuelve símbolos de la tabla de enlaces dinámicos (PLT) asociándolos con la tabla de despacho HLE y procesa las reubicaciones dinámicas.
- **`guest_memory`**: Gestiona el mapa de memoria virtual de 32 bits, proporcionando funciones de traducción bidireccional segura entre punteros invitados de 32 bits y punteros reales de 64 bits del host.
- **`hle_dispatcher`**: Contiene los manejadores de Emulación de Alto Nivel (HLE) para 178 símbolos de bibliotecas estándar (Bionic libc, libm, libz y OpenGL ES 1.1). Cuando el código invitado ejecuta una llamada a través de la PLT, Dynarmic dispara una instrucción SVC que este módulo intercepta para extraer los parámetros de los registros de la CPU emulada (`r0`–`r3` y pila) y ejecutar la rutina equivalente nativa de 64 bits.

### 3.3. Subsistema de Sistema de Archivos (`include/gunbros/filesystem/`, `src/filesystem/`)
- **`path_mapper`**: Resuelve y normaliza todas las rutas de archivos que solicita el juego. Transforma rutas fijas obsoletas (como `/sdcard/glu/...` o `/data/data/com.glu.android.gunbros_free/...`) hacia el almacenamiento privado seguro de la aplicación (Scoped Storage). Corrige el fallo clásico de Glu que recortaba nombres de archivos (`ackTOC*` -> `packTOC*`) y elimina prefijos virtuales (`data:`, `temp:`, `cache:`).
- **`file_handles`**: Tabla virtual de descriptores de archivo con índices del `1` al `64`. Protege los descriptores estándar del sistema operativo anfitrión (`0` para stdin, `1` para stdout, `2` para stderr, sockets de logcat y pipes internos de EGL) evitando que el código emulado pueda cerrarlos o alterarlos accidentalmente.
- **`file_operations`**: Implementa `fopen`, `fclose`, `fread`, `fwrite`, `fseek`, `ftell`, `stat`, `remove` y `rename`. Aplica vaciado inmediato de búfer (`fflush`) en cada escritura para prevenir pérdidas de datos si Android congela el proceso.
- **`directory_operations`**: Emula las operaciones de directorios de POSIX (`opendir`, `readdir`, `closedir`, `mkdir`, `rmdir`), traduciendo estructuras `dirent` de 64 bits a la estructura esperada por el código de 32 bits.
- **`filesystem_logger`**: Sistema centralizado de auditoría que registra cada operación de archivo, bytes leídos/escritos, rutas resueltas y códigos de error `errno` en Logcat bajo la etiqueta `GunBrosFS`.

### 3.4. Subsistema de Plataforma (`include/gunbros/platform/`, `src/platform/`)
- **`android_window`**: Interfaz con `ANativeWindow` de Android y el contexto EGL (OpenGL ES 1.1 CM). Calcula automáticamente el centrado y bandas negras (*letterboxing* / *pillarboxing*) para adaptar el formato original 5:3 / 15:9 a pantallas ultrapanorámicas modernas (20:9 o 21:9), ajustando las coordenadas de corte en `glViewport` y `glScissor`.
- **`android_audio`**: Motor de reproducción de audio de baja latencia basado en AAudio (con soporte de respaldo para AudioTrack), alimentado desde un búfer circular continuo.
- **`pcm_ring`**: Búfer circular de bytes lock-free para un único productor y un único consumidor (SPSC) de 64 KB de capacidad, implementado con operaciones atómicas (`acquire`/`release`) para garantizar transferencia de audio fluida y sin bloqueos entre hilos.
- **`jni_env_helper`**: Utilidades para obtener el puntero `JNIEnv*` del hilo actual y gestionar referencias globales de la JVM de manera segura entre hilos secundarios.

### 3.5. Subsistema de Compatibilidad (`include/gunbros/compatibility/`, `src/compatibility/`)
- **`game_patches`**: Aplica parches binarios en caliente directamente sobre la memoria del juego tras cargar el ELF:
  - Anula llamadas bloqueantes a servidores antiguos de Glu y GameSpy que ya no existen en Internet.
  - Habilita soporte multitáctil contemporáneo para controles de doble palanca (*dual-stick*).
  - Corrige matrices de transformación de modelos 3D y fogonazos de armas.
- **`jni_virtual_machine`**: Estructuras sintéticas en memoria emulada que simulan una instancia funcional de `JavaVM` y `JNIEnv` para resolver las consultas del juego sobre idioma, país, modelo de teléfono y estado de red sin necesidad de llamar a la JVM de Android en cada ocasión.

---

## 4. Mapa de Memoria Virtual Emulada

Dynarmic requiere un espacio de direccionamiento de 32 bits continuo y predecible. La memoria virtual se organiza de la siguiente manera:

| Rango de Direcciones Invitado | Tamaño | Propósito |
| :--- | :--- | :--- |
| `0x00000000 - 0x00600000` | 6 MB | Segmentos de código (.text) y datos (.data, .rodata, .bss) de `libandroidplatform.so`. |
| `0x60000000 - 0x70000000` | 256 MB | Heap emulado para asignaciones dinámicas (`malloc`, `calloc`, `realloc`, `operator new`). |
| `0x70000000 - 0x70800000` | 8 MB | Pila de ejecución invitada (Guest Stack), con crecimiento hacia abajo desde `0x707ffff0`. |
| `0x80000000 - 0x80020000` | 128 KB | Tabla de stubs SVC de interrupción HLE y código auxiliar inyectado. |
| `0xffff0000 - 0x100000000` | 64 KB | Commpage de Linux de 32 bits (soporte para llamadas del kernel como `__kuser_cmpxchg`). |

---

## 5. Modelo de Concurrencia y Sincronización

1. **Cerrojo Principal del Emulador (`g_emu_mutex`)**:
   Serializa el acceso a la instancia de Dynarmic. Garantiza que solo un hilo a la vez ejecute código emulado de la CPU invitada, permitiendo al mismo tiempo llamadas reentrantes desde las rutinas HLE.
2. **Audio Ring Buffer Lock-Free**:
   El hilo del emulador escribe muestras PCM de audio mientras el hilo de callback de AAudio las consume. Al utilizar un diseño de búfer circular SPSC con barreras de memoria atómicas (`__ATOMIC_ACQUIRE` y `__ATOMIC_RELEASE`), no se requieren cerrojos ni mutexes, eliminando chasquidos o pausas en el sonido.
3. **Aislamiento de Descriptores de Archivo**:
   La tabla de handles virtuales está sincronizada con `s_handles_mutex`. Las aperturas, lecturas y cierres son seguros incluso si el motor del juego utiliza hilos de carga en segundo plano para recursos.
4. **Cola de Entrada Táctil Desacoplada**:
   Los eventos de toque provenientes de la interfaz de usuario de Android se encolan en una lista protegida por mutex (`s_touch_mutex`). Al inicio de cada fotograma, el hilo de render vacía esta cola y la entrega al motor emulado, evitando caídas de fotogramas por congestión de eventos táctiles.

# Informe de Cambios y Revisión Técnica: GunBros ARM64 Bridge

**Fecha de finalización**: Octubre 2026  
**Rama de trabajo**: `refactor/review-2026-10`  
**Etiqueta de archivo**: `legacy-archive`  
**Estado de pruebas**: 7/7 superadas (100% CTest pass rate)  
**Estado de compilación NDK**: Exitosa (`build/android/libandroidplatformjni.so` y `GunBros_Android16_Dynarmic.apk` generados)

---

## 1. Resumen de Actuaciones por Punto

### Fase 1: Corrección de Defectos de Persistencia (Prioridad Máxima)

* **1.1 Corrección de signo en `h_fseek` y auditoría de retornos**:
  * **Acción**: En `src/hle/libc_stdio.c` (previamente `hle_dispatcher.c`), se corrigió el casteo del offset en `h_fseek`. Originalmente `(long)c->r1` interpretaba el valor `uint32_t` como un entero positivo sin signo de 64 bits (~4 GB) ante offsets negativos en `SEEK_END` o `SEEK_CUR`. Se modificó a `(long)(int32_t)c->r1`. Se auditó `h_ftell`, comprobando que devuelve `(uint32_t)-1` ante errores.
  * **Verificación**: Verificado mediante la nueva prueba unitaria `test_fseek_negative_offset` en `tests/test_hle_libc.c`, validando desplazamientos negativos desde `SEEK_END` y `SEEK_CUR` con lecturas de datos exactas.
  * **Commit**: `7ceccae fix(hle): preserve sign in h_fseek offset and audit ftell error return (1.1)`

* **1.2 Corrección de desbordamiento de ancho en `h_time` y auditoría temporal**:
  * **Acción**: `h_time` escribía un `time_t` de 64 bits (host) en la memoria del guest de 32 bits si `c->r0 != 0`, sobrescribiendo 4 bytes contiguos de memoria adyacente. Se corrigió forzando la escritura de `uint32_t` mediante `guest_ptr(c->r0, 4)`. Se auditaron `gettimeofday`, `clock_gettime`, `difftime`, `localtime`, `gmtime`, `mktime`, `ctime` y `strftime`, garantizando límites de 32 bits y validación de punteros.
  * **Verificación**: Verificado mediante `test_time_4byte_write` en `tests/test_hle_libc.c`, comprobando con una palabra de control (*canary*) de 4 bytes contigua que no existe desbordamiento de memoria.
  * **Commit**: `33f091f fix(hle): write 32-bit uint32_t in h_time and bounds-check time handlers (1.2)`

* **1.3 Relleno completo de `struct stat` con layout Bionic ARM32**:
  * **Acción**: En `src/filesystem/file_operations.c`, `gunbros_stat` solo rellenaba `st_mode` y `st_size`. Se contrastaron las cabeceras de Bionic en Android NDK r26d (`asm-generic/stat.h`) y se implementó el layout exacto de 104 bytes:
    * `ino` @ 12 (4B)
    * `mode` @ 16 (4B)
    * `nlink` @ 20 (4B)
    * `uid` @ 24 (4B), `gid` @ 28 (4B)
    * `size` @ 48 (8B, uint64_t)
    * `blksize` @ 56 (4B)
    * `blocks` @ 64 (8B, uint64_t)
    * `atime` @ 72 (4B), `atime_nsec` @ 76 (4B)
    * `mtime` @ 80 (4B), `mtime_nsec` @ 84 (4B)
    * `ctime` @ 88 (4B), `ctime_nsec` @ 92 (4B)
    * `ino64` @ 96 (8B)
    * Tamaño total: 104 bytes. Escritura segura mediante `memcpy` sin accesos desalineados.
  * **Verificación**: Verificado en `tests/filesystem/test_file_operations.c` y en `tests/test_hle_libc.c` (`test_stat_bionic_layout`).
  * **Commit**: `7c76a1e fix(fs): populate full bionic ARM32 struct stat layout using memcpy and add host test (1.3)`

* **1.4 Normalización de anchos en `h_sscanf` y soporte para argumentos en pila**:
  * **Acción**: `h_sscanf` solo aceptaba 2 argumentos en registros (`r2`, `r3`) y pasaba punteros al `sscanf` nativo con especificadores `%ld`/`%lu`, causando escrituras de 8 bytes en enteros de 4 bytes del guest. Se implementó una función normalizadora de formato (`normalize_scanf_format`) que degrada `%ld`/`%lu`/`%lx` a `%d`/`%u`/`%x`, y se amplió el despacho variádico hasta `MAX_SSCANF_ARGS` (16 argumentos), extrayendo los argumentos restantes a partir de `sp` en memoria guest. Se añadió un log de advertencia si el número de conversiones excede los argumentos soportados.
  * **Verificación**: Verificado mediante `test_sscanf_multi_args` en `tests/test_hle_libc.c` con 5 conversiones (%s, %d, %ld, %u, %f), leyendo parámetros desde registros y pila con canarios de integridad intactos.
  * **Commit**: `a2fa1a2 fix(hle): normalize sscanf format to guest integer width and support stack arguments (1.4)`

* **1.5 Stubs informativos con registro de LR para llamadas no implementadas**:
  * **Acción**: Se crearon manejadores informativos con aviso único por función (`stub_warn_once`) para `fprintf`, `fdopen`, `mkstemp`, `close`, `dup`, `ioctl`, `puts`. Para `fprintf` y `fdopen` se añadió una alerta crítica si el flujo de salida no corresponde a `stdout`/`stderr`, previniendo escrituras silenciosas de datos en disco no capturadas.
  * **Verificación**: Compilación e inspección de salidas bajo depuración en host y Android.
  * **Commit**: `90c4fb2 feat(hle): add informative stub logging for fprintf, fdopen, mkstemp, close, dup, ioctl, puts (1.5)`

* **1.6 Trazas bajo `BRIDGE_DEBUG` para guardados y recursos APK**:
  * **Acción**: Se añadieron trazas con el flag `BRIDGE_DEBUG` en `gunbros_fopen` para interceptar aperturas sobre archivos clave (`savegame.dat`, `prefs.dat`, `-1_10*`) registrando el modo y origen. En `OpenAPKFile` se añadió logging informativo de la petición antes de devolver NULL.
  * **Verificación**: Compilación con `-DBRIDGE_DEBUG` verificada con `scripts/build.sh`.
  * **Commit**: `101c18d feat(debug): add BRIDGE_DEBUG traces for savegame fopen and OpenAPKFile (1.6)`

---

### Fase 2: Diagnóstico y Registro (Logging)

* **2.1 Unificación de etiquetas Logcat (`GunBrosARM64` y `GunBrosFS`)**:
  * **Acción**: Se unificaron las etiquetas de registro: `GunBrosARM64` para el núcleo del puente y emulador, y `GunBrosFS` para el subsistema de archivos (`filesystem_logger.c`). Se actualizó `scripts/collect-logs.sh` para capturar ambas etiquetas (`GunBrosARM64:V GunBrosFS:V *:S`) y se corrigieron los ejemplos y tags en `docs/filesystem.md` y `docs/architecture.md`.
  * **Verificación**: Comprobación de sintaxis y ejecución de `scripts/collect-logs.sh`.
  * **Commit**: `5fceb1d fix(logging): unify GunBrosFS tag in filesystem_logger, collect-logs.sh and docs (2.1)`

* **2.2 Trazado integral de E/S de guardado y volcado hexadecimal**:
  * **Acción**: Se instrumentó `file_operations.c` para registrar bajo `BRIDGE_DEBUG` todas las operaciones sobre `savegame.dat` y `prefs.dat` (`stat`, `fopen`, `fread` pedido vs obtenido, `fseek` con offset y whence, `ftell`, `rewind`, `fclose`). Al cerrar un descriptor abierto con modo `"wb"`, se realiza un volcado en logcat de los primeros 64 bytes en formato hexadecimal.
  * **Verificación**: Verificado mediante la ejecución de `test_file_operations` y `test_hle_libc`.
  * **Commit**: `4ebdd85 feat(fs): trace savegame file operations and dump wb hexdump under BRIDGE_DEBUG (2.2)`

* **2.3 Creación de protocolo de diagnóstico de persistencia**:
  * **Acción**: Se redactó `docs/save-debugging.md` describiendo el procedimiento metódico de 5 pasos para discernir entre fallos de persistencia en disco vs. rechazo de perfiles por la lógica interna del motor.
  * **Commit**: `38c695a docs: create save-debugging.md persistence diagnostic protocol (2.3)`

---

### Fase 3: Refactorización Estructural

* **3.1 Descomposición del despachador monolítico `hle_dispatcher.c`**:
  * **Acción**: Se fragmentó el archivo de 945 líneas en componentes especializados dentro de `src/hle/`:
    * `src/hle/libc_string.c`: memoria, cadenas, printf/scanf.
    * `src/hle/libc_time.c`: tiempo y calendario.
    * `src/hle/libc_stdio.c`: archivos y directorios.
    * `src/hle/net_stubs.c`: stubs de red y depuración.
    * `src/hle/gles1.c`: OpenGL ES 1.1 CM y extensiones OES.
    * `src/hle/hle_table.c`: registro central y despacho SVC.
    * `src/hle/hle_internal.h`: cabecera interna común.
  * **Verificación**: `scripts/run_tests.sh` y `scripts/build.sh` superados.
  * **Commit**: `6841aff refactor(hle): split monolithic hle_dispatcher.c into modular src/hle/ components (3.1)`

* **3.2 Resolución dinámica de imports ELF por nombre**:
  * **Acción**: Se reemplazó el array estático `s_plt_names[N_PLT]` por un mecanismo dinámico (`hle_resolve_import`). Cada módulo de `src/hle/` expone una tabla `{nombre, handler}` que se registra en `hle_init()`. Al cargar el ELF, `elf_loader.c` busca el símbolo por nombre y le asigna una ranura de stub PLT dinámica. Si un símbolo del guest no tiene handler, se registra un error explícito en logcat.
  * **Verificación**: Pruebas de enlace dinámico y ejecución en CTest y NDK.
  * **Commit**: `39f6a6f refactor(hle): resolve guest imports dynamically by name and register handlers per module (3.2)`

* **3.3 Centralización de direcciones mágicas en `guest_symbols.h`**:
  * **Acción**: Se creó `include/gunbros/compatibility/guest_symbols.h` centralizando todas las direcciones virtuales fijas, constantes y offsets de estructuras del binario de 32 bits (`GUEST_ADDR_APP_PTR`, `GUEST_FN_SELECT_CHAR`, offsets de `GunBros`, etc.). Se eliminaron números mágicos dispersos en `bridge_core.c`, `game_patches.c` y `elf_loader.c`.
  * **Verificación**: Verificación de compilación sin cambios en valores binarios.
  * **Commit**: `16f02d4 refactor(compat): centralize magic guest addresses and offsets in guest_symbols.h (3.3)`

* **3.4 Tabla declarativa de parches con verificación de opcodes**:
  * **Acción**: Se reorganizó `game_patches.c` en base a una tabla de estructuras `game_patch_entry_t { addr, expected_old, new_value, name, verified }`. Si `expected_old` está definido y no coincide con la memoria leída, se aborta el parche y se notifica el error. Bajo `BRIDGE_DEBUG`, se registran en logcat los opcodes originales encontrados (`[PATCH:CAPTURE]`) para facilitar su incorporación en frío.
  * **Verificación**: Compilación con validación condicional y registro de parches.
  * **Commit**: `38a16fe refactor(compat): convert game_patches.c to table-driven with expected_old verification and BRIDGE_DEBUG capture (3.4)`

* **3.5 Verificación SHA-256 del binario guest ARM32**:
  * **Acción**: Se implementó un algoritmo SHA-256 en C99 puro (sin dependencias externas ni bibliotecas criptográficas pesadas) en `src/emulator/elf_loader.c`. Al cargar el ELF `libandroidplatform.so`, se calcula y registra su SHA-256. Se declaró la macro `EXPECTED_GUEST_SHA256` en `guest_symbols.h`: si está vacía solo advierte; si se rellena y discrepa, se rehúsa a aplicar los parches binarios.
  * **Verificación**: Validación del hash calculado frente a `sha256sum` del binario guest en tests de host.
  * **Commit**: `a2fa988 feat(loader): verify loaded guest ARM32 ELF SHA-256 against EXPECTED_GUEST_SHA256 (3.5)`

* **3.6 Desacoplamiento de hooks de juego y tabla de métodos JNI con audio aislado**:
  * **Acción**:
    1. Se extrajo la lógica de selección de personaje en `TouchEnded` de `bridge_core.c` a `src/compatibility/game_hooks.c` (`game_hooks_on_touch_ended`).
    2. Se reemplazaron las cadenas de `strcmp` secuenciales en `jni_virtual_machine.c` por una tabla declarativa `s_jni_method_table[]` en `src/compatibility/jni_methods.c`.
    3. Se separaron las rutinas de audio JNI (`InitialiseSoundEngine`, `StartAudioStream`, etc.) en `src/compatibility/jni_audio.c`.
  * **Verificación**: Verificación en host y compilación NDK.
  * **Commit**: `242092c refactor(compat): extract character select to game_hooks and table-drive JNI methods with isolated audio (3.6)`

* **3.7 Documentación de procedencia del blob `guest_helpers_bin.h`**:
  * **Acción**: Se añadió un comentario de cabecera en `guest_helpers_bin.h` y una sección detallada en `docs/compatibility.md` documentando que el array binario de 460 bytes contiene el código máquina ARM32 inyectado para `qsort`/`heapsort` con callbacks guest, cuyo fuente original no está en el repositorio y queda pendiente de aportación por el autor.
  * **Commit**: `f3dc1ad docs(compat): document provenance of guest_helpers_bin blob (3.7)`

---

### Fase 4: Batería de Pruebas

* **4.1 Pruebas unitarias en host para HLE libc (`test_hle_libc`)**:
  * **Acción**: Se independizaron los manejadores de `libc_string.c`, `libc_time.c` y `libc_stdio.c` de cualquier dependencia gráfica (OpenGL/EGL) y de Dynarmic mediante la cabecera `include/gunbros/hle/hle_libc.h`. Se creó `tests/test_hle_libc.c` para verificar:
    * `h_fseek` con desplazamientos negativos (`SEEK_END`, `SEEK_CUR`) y `h_ftell`.
    * `h_time` escribiendo únicamente 4 bytes (sin desborde sobre memoria guest contigua).
    * `h_stat` verificando el layout Bionic ARM32 de 104 bytes y canario final.
    * `h_sscanf` con múltiples argumentos en registros y pila, normalizando `%ld`.
  * **Verificación**: Ejecución con CTest (100% pass).
  * **Commit**: `288dc61 test(hle): make libc handlers testable on host and add test_hle_libc (4.1)`

* **4.2 Renombrado de persistencia host y runner para guardados reales (`golden_save_runner`)**:
  * **Acción**: Se renombró `test_persistence.c` a `tests/filesystem/test_host_io_persistence.c` aclarando mediante cabecera que valida la semántica de E/S atómica del host con structs sintéticos. Se implementó `tests/golden/golden_save_runner.c` que reproduce la secuencia exacta de llamadas del guest (`stat` -> `fopen "rb"` -> `fseek SEEK_END` -> `ftell` -> `rewind` -> `fread` -> `fclose` -> `SafeWriteFile`). Se creó `tests/golden/README.md` explicando cómo aportar un volcado real (`savegame.dat`).
  * **Verificación**: Ejecución de ambos binarios dentro de la suite de CTest.
  * **Commit**: `63bf1be test(fs): rename persistence test to test_host_io_persistence and add golden save runner with docs (4.2)`

* **4.3 Integración de pruebas en CMake/CTest y ejecución aislada**:
  * **Acción**: Se registraron todas las pruebas en `CMakeLists.txt` (7 suites en total: `test_path_mapper`, `test_file_operations`, `test_host_io_persistence`, `test_pcm_ring`, `test_guest_memory`, `test_hle_libc`, `golden_save_runner`). Se añadió limpieza y aislamiento de carpetas temporales (`/tmp/gunbros_*`) en `scripts/run_tests.sh`.
  * **Verificación**: `./scripts/run_tests.sh` ejecuta las 7 pruebas con éxito.
  * **Commit**: `43f571b test(ci): register new test targets in CMake and ensure run_tests.sh executes suite with isolation (4.3)`

---

### Fase 5: Higiene del Repositorio

* **5.1 Preservación con tag `legacy-archive` y eliminación de `legacy/`**:
  * **Acción**: Se confirmó la existencia del tag git inmutable `legacy-archive` conservando el código previo. Se eliminó la carpeta `legacy/` del árbol de trabajo y se actualizó `README.md`.
  * **Commit**: `d88a0bf chore: purge legacy/ directory after preserving under legacy-archive git tag (5.1)`

* **5.2 Eliminación de `libandroidplatformjni.so` en la raíz del repositorio**:
  * **Acción**: Se eliminó mediante `git rm` el archivo binario precompilado de la raíz y se retiró la directiva `cp "$SO_PATH" "$PROJECT_ROOT/libandroidplatformjni.so"` de `scripts/build.sh`. La salida del build queda confinada en `build/android/`.
  * **Commit**: `4ea4800 build: remove root libandroidplatformjni.so and stop copying from build.sh (5.2)`

* **5.3 Script generador `make_base_apk.sh` y validación en `package.sh`**:
  * **Acción**: Se creó `scripts/make_base_apk.sh`, que recibe la ruta a un APK original de Gun Bros v1.1.9, verifica la presencia de `assets/libandroidplatformjni.so`, limpia las firmas obsoletas de `META-INF/` y genera `base_template.apk`. Se actualizó `package.sh` para emitir un mensaje de error claro y explicativo si la plantilla base no existe.
  * **Commit**: `0e508f3 feat(build): add make_base_apk.sh script and explicit missing template error in package.sh (5.3)`

* **5.4 Creación de `LICENSE` y advertencia de no distribución en `README.md`**:
  * **Acción**: Se creó el archivo `LICENSE` indicando que la elección formal de licencia para el código del puente queda pendiente del autor, e incorporando el aviso legal de derechos de autor de Glu Mobile / EA. Se añadió una advertencia destacada en `README.md` indicando que el repositorio no contiene ni distribuye APKs ni assets.
  * **Commit**: `ea4af9d docs(legal): add LICENSE disclaimer and README non-distribution notice (5.4)`

* **5.5 Actualización y blindaje de `.gitignore`**:
  * **Acción**: Se revisó y actualizó `.gitignore` para cubrir de forma estricta: `build/`, `logs/`, `*.apk`, `*.so`, `*.idsig`, `tools/`, `third_party/dynarmic` y `third_party/boost`, preservando al mismo tiempo el keystore versionado en `third_party/keystore/debug.keystore`.
  * **Commit**: `640c458 chore: update .gitignore to cover logs, build, binaries, tools and third_party (5.5)`

---

### Fase 6: Documentación y Entrega

* **6.1 Actualización integral del `README.md`**:
  * **Acción**: Árbol de directorios sincronizado con la estructura real del repositorio; estado de persistencia actualizado con los defectos corregidos; enlaces técnicos comprobados; flujo de construcción documentado con `make_base_apk.sh`.
  * **Commit**: `ee4bf25 docs(readme): update structure, persistence status, doc links and build workflow (6.1)`

* **6.2 Actualización de `docs/architecture.md` y `docs/compatibility.md`**:
  * **Acción**: Se documentaron los cambios arquitectónicos: modularización de HLE, tabla declarativa de parches con captura, `game_hooks.c` y desacoplamiento de métodos JNI y audio.
  * **Commit**: `edfe813 docs(arch,compat): document HLE modularization, table-driven patches and decoupled JNI (6.2)`

---

## 2. Discrepancias Encontradas Respecto al Informe Previo

Durante el análisis del código real se identificaron las siguientes discrepancias con el documento de revisión previo:

1. **Ubicación de `safe_guest_snprintf`**: El informe asumía que todo el formateo de cadenas residía en `hle_dispatcher.c`. En el código real, `safe_guest_snprintf` estaba implementado al final de `src/compatibility/jni_virtual_machine.c`. Para lograr que la capa HLE de libc fuera autónoma y comprobable en host sin arrastrar dependencias de Android, `safe_guest_snprintf` fue reubicado limpiamente en `src/hle/libc_string.c`.
2. **Presencia local de `base_template.apk`**: El informe indicaba que `base_template.apk` no existía en el repositorio. En el espacio de trabajo local del usuario existía un archivo de 223 MB sin versionar en Git. Se mantuvo fuera del seguimiento Git mediante `.gitignore` y se implementó `scripts/make_base_apk.sh` para garantizar su generación reproducible por cualquier desarrollador sin infringir la Regla 5.
3. **Despacho JNI no variádico vs. variádico**: Se observó que el índice de métodos JNI `CallNonvirtual*Method` (`idx 64..93`) recibe `clazz` en `r2` y `methodID` en `r3`, a diferencia de `CallObjectMethod` estándar que recibe `methodID` en `r2`. La normalización en `jni_methods_dispatch` unificó este cálculo corrigiendo discrepancias de despacho en métodos no virtuales.
4. **Declaración de `strptime` en Host**: En Linux glibc, `strptime` requiere definir explícitamente `_GNU_SOURCE` o `_XOPEN_SOURCE` antes de `<time.h>`. Se incorporó `#define _GNU_SOURCE` en `libc_time.c` para permitir la compilación limpia del test de host sin alterar el comportamiento de Bionic.

---

## 3. Asuntos Pendientes del Autor ("Pendiente del Autor")

Los siguientes puntos han sido preparados técnicamente pero requieren aportación o decisión directa por parte del autor del proyecto:

1. **Hash Criptográfico `EXPECTED_GUEST_SHA256` (`include/gunbros/compatibility/guest_symbols.h`)**:
   * *Estado actual*: Definido como cadena vacía `""`. El cargador `elf_loader.c` calcula el SHA-256 del binario cargado y lo imprime en Logcat (`Loaded guest ARM32 ELF SHA-256: <hash>`).
   * *Acción requerida*: Copiar el hash obtenido en la sesión de ejecución del APK original y asignarlo a `EXPECTED_GUEST_SHA256` para activar el bloqueo estricto contra binarios corruptos o versiones no compatibles.

2. **Opcodes Originales para `expected_old` en `game_patches.c`**:
   * *Estado actual*: Los parches A (`0x00366878`) y J (`0x0037a4e8`) están marcados como verificados (`verified = true`). Los parches B, C, D y E tienen `expected_old = 0` y `verified = false`.
   * *Acción requerida*: Arrancar el juego en un emulador o dispositivo con `BRIDGE_DEBUG` activo. El emulador emitirá líneas con el tag `[PATCH:CAPTURE] Patch '<nombre>' original opcode at 0x... is 0x...`. Copiar esos valores en el campo `expected_old` de cada entrada en `s_patches[]` y marcar `verified = true`.

3. **Código Fuente del Helper ARM32 (`guest_helpers_bin.h`)**:
   * *Estado actual*: Se conserva el blob precompilado de 460 bytes inyectado en `0x8000d000`. De acuerdo con la Regla 7, no se inventó ni decompiló código ciego.
   * *Acción requerida*: Si el autor conserva el archivo original en ensamblador o C (por ejemplo `guest_qsort.c` o `guest_helpers.s`), incorporarlo en una carpeta `src/guest_helpers/` junto con un script de ensamblado con el toolchain de 32 bits del NDK.

4. **Elección Formal de Licencia (`LICENSE`)**:
   * *Estado actual*: Archivo `LICENSE` con texto de reserva legal y aviso de derechos de autor.
   * *Acción requerida*: El autor debe definir la licencia de código abierto deseada (MIT, Apache 2.0, GPLv2/v3). Téngase en cuenta que la dependencia `Dynarmic` está licenciada bajo BSD-3-Clause.

5. **Aportación de Volcado de Guardado para Prueba Golden (`tests/golden/`)**:
   * *Estado actual*: `golden_save_runner.c` y su documentación están listos y se integran en CTest pasando de forma stubbed si no hay savegame presente.
   * *Acción requerida*: Extraer un `savegame.dat` de una partida real y ubicarlo en `tests/golden/savegame.dat` para ejecutar la validación completa en el runner.

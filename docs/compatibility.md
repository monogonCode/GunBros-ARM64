# Capa de Compatibilidad y Emulación HLE: GunBros ARM64 Bridge

## 1. Visión General

La capa de compatibilidad (`include/gunbros/compatibility/`, `src/compatibility/` y `src/hle/`) hace posible la ejecución del binario original de 32 bits `libandroidplatform.so` en Android moderno sin tener acceso al código fuente del juego. 

Combina cuatro mecanismos fundamentales:
1. **Símbolos y Direcciones Centralizadas (`guest_symbols.h`)**: Centralización de todas las direcciones mágicas, constantes y offsets del guest en una única cabecera tipada.
2. **Tabla Declarativa de Parches Binarios (`game_patches.c`)**: Modificación controlada en caliente con validación de opcodes previos (`expected_old`) y captura bajo `BRIDGE_DEBUG`.
3. **Entorno JNI Sintético y Modular (`jni_virtual_machine.c`, `jni_methods.c`, `jni_audio.c`)**: Despacho de métodos JNI por tabla asociativa desacoplada y subsistema de audio aislado.
4. **Despacho HLE Modular (`src/hle/`)**: Intercepción de 178 funciones de sistema y gráficos organizada por módulos (`libc_string`, `libc_time`, `libc_stdio`, `net_stubs`, `gles1`, `hle_table`) con resolución dinámica por nombre.

---

## 2. Parches Binarios en Memoria (`game_patches.c`)

Inmediatamente después de que el cargador ELF (`elf_loader.c`) mapea los segmentos en memoria, calcula el hash SHA-256 del binario y valida opcionalmente `EXPECTED_GUEST_SHA256`. Antes de ejecutar constructores estáticos, la función `game_patches_apply_all()` aplica la tabla de parches `s_patches[]`:

```c
typedef struct {
    uint32_t addr;          // Dirección virtual guest
    uint32_t expected_old;  // Opcode original esperado (0 si no verificado)
    uint32_t new_value;     // Nuevo opcode a escribir
    const char *name;       // Nombre descriptivo
    bool verified;          // true si expected_old está verificado
} game_patch_entry_t;
```

### Comportamiento y Verificación de Parches
- **Parches Verificados**: Se comprueba el opcode original en memoria antes de escribir. Si coincide, se aplica; si discrepa, se aborta la aplicación y se registra error en Logcat.
- **Parches No Verificados (`expected_old == 0`)**: Se aplican advirtiendo en el log.
- **Modo Captura (`BRIDGE_DEBUG`)**: Al iniciar, el emulador registra en Logcat `[PATCH:CAPTURE]` con el valor hexadecimal original de cada parche para que el autor pueda rellenar los opcodes esperados.

### Catálogo de Parches Declarados

| ID | Dirección Virtual | Código Original | Código Parcheado | Componente / Propósito |
| :--- | :--- | :--- | :--- | :--- |
| **A** | `GUEST_PATCH_RESLOADER` (`0x00366878`) | `0x0affffc8` (`beq`) | `0xe1a00000` (`nop`) | **Bypass de Servidor de Recursos**: Evita un bucle infinito en `CResourceLoader::LoadNext` que esperaba respuesta de servidores Glu extintos. |
| **B** | `GUEST_PATCH_DUALSTICK` (`0x001fd450`) | Pendiente captura | Rutina multi-pointer | **Multitáctil de Doble Palanca**: Adapta el control táctil para gestionar punteros independientes para mover y disparar simultáneamente. |
| **C** | `GUEST_PATCH_SKELETON` (`0x0021be00`) | Pendiente captura | Guarda de rango | **Estabilidad de Esqueleto 3D**: `CMesh::GetNodeAt` añade comprobación de límites para prevenir fallos de segmentación por huesos no definidos. |
| **D** | `GUEST_PATCH_TIMING` (`0x0021b330`) | Pendiente captura | Clamping de tiempo | **Pantallas de Alta Frecuencia (90Hz / 120Hz)**: Evita división por cero o saltos temporales negativos en `CMesh::GetInterpolationValues`. |
| **E** | `GUEST_PATCH_MUZZLE` (`0x002c918c`) | Pendiente captura | Matriz traspuesta | **Orientación de Fogonazo de Arma**: Corrige la orientación del modelo 3D de fogonazo en `CGun` para que coincida con el cañón. |
| **J** | `GUEST_PATCH_GAMESPY` (`0x0037a4e8`) | `0xe3a00000` / `0xe12fff1e` | `mov r0, #0` + `bx lr` | **Bypass de Red GameSpy**: Elude la conexión obligatoria a servidores GameSpy extintos (`peerchat.gamespy.com`), permitiendo jugar en solitario. |

---

## 3. Ganchos de Comportamiento del Juego (`game_hooks.c`)

La lógica específica del juego desacoplada de `bridge_core.c` reside en `src/compatibility/game_hooks.c`:
- **`game_hooks_on_touch_ended(int x, int y)`**: Se ejecuta en eventos táctiles de liberación (`TouchEnded`). Si el motor se encuentra en el estado de menú `PLAYER_SELECT` (estado 5), detecta si el usuario pulsó la mitad izquierda (Percy Gun) o derecha (Francis Gun) de la pantalla y despacha la llamada de selección de personaje (`select_char`).

---

## 4. Máquina Virtual JNI Sintética y Despacho Modular (`jni_methods.c`, `jni_audio.c`)

El despacho de métodos JNI emulados ya no emplea cadenas de `strcmp` secuenciales en el despachador general. Se organiza mediante:
1. **Tabla de Despacho `s_jni_method_table[]`**: Asocia cada nombre de método con su manejador especializado `jni_method_handler_t`.
2. **Aislamiento de Audio (`jni_audio.c`)**: Maneja de forma independiente `InitialiseSoundEngine`, `StartAudioStream`, `StopAudioStream`, `GetAndroidMinBufferSize`, `mp3Event` y `SetVolume`.
3. **Consultas de Sistema y Gráficos**: Métodos como `eglGetError`, `GetDeviceOrientation`, `OpenAPKFile`, `resdlStringEvent` y consultas de memoria se resuelven en funciones puras e independientes.

---

## 5. Despacho HLE Modular (`src/hle/`)

El despachador HLE monolítico se ha estructurado en 6 módulos cohesivos:
- `libc_string.c`: Formateo de cadenas (`snprintf` seguro), funciones de memoria y `sscanf` normalizado con anchos de 32 bits y soporte para argumentos en pila.
- `libc_time.c`: Manejo de reloj y tiempo de calendario con escrituras estrictas de 4 bytes para evitar corrupción de memoria contigua en el guest.
- `libc_stdio.c`: Glue de operaciones de archivo y directorios con preservación de signo en `fseek` y layout Bionic ARM32 en `stat`.
- `net_stubs.c`: Stubs para primitivas de red obsoletas.
- `gles1.c`: Intercepción y reenvío de primitivas y matrices OES de OpenGL ES 1.1 CM.
- `hle_table.c`: Registro declarativo de módulos (`hle_register_module`) y resolución dinámica de símbolos ELF por nombre (`hle_resolve_import`), advirtiendo en Logcat de cualquier símbolo importado que carezca de manejador.

### 5.1. Operaciones de Archivos
- `fopen`, `fclose`, `fread`, `fwrite`, `fseek`, `ftell`, `stat`, `remove`, `rename`, `opendir`, `readdir`, `closedir`, `mkdir`, `rmdir` se enrutan de forma unificada hacia el subsistema `gunbros/filesystem`.

### 5.2. Gráficos OpenGL ES 1.1 y Extensiones
- **Llamadas Base**: `glViewport`, `glClear`, `glBindTexture`, `glDrawArrays`, `glDrawElements`, `glEnable`, `glDisable`, etc., se reenvían al contexto OpenGL ES 1.1 CM nativo.
- **Extensiones OES para Modelos 3D**: GunBros utiliza extensiones de matriz de paleta de huesos para animaciones de personajes. Se implementan manejadores para:
  - `glCurrentPaletteMatrixOES`
  - `glMatrixIndexPointerOES`
  - `glWeightPointerOES`
  - `glClipPlanex` y variantes en punto fijo (`x`)

### 5.3. Adaptación a Pantallas Ultrapanorámicas (Letterboxing)
En dispositivos contemporáneos con pantallas 20:9 o 21:9 (por ejemplo, resoluciones 2400x1080 o 2772x1240), el juego original (diseñado para 800x480) sufriría deformaciones o elementos fuera del encuadre.

El despachador intercepta `glViewport` y `glScissor` aplicando una transformación afín:
$$\text{host\_x} = \text{vp\_x} + \left( \frac{\text{guest\_x} \times \text{vp\_w}}{\text{guest\_screen\_w}} \right)$$
$$\text{host\_y} = \text{vp\_y} + \left( \frac{\text{guest\_y} \times \text{vp\_h}}{\text{guest\_screen\_h}} \right)$$

Las bandas negras laterales son limpiadas mediante `glClear(GL_COLOR_BUFFER_BIT)` sobre la superficie física completa antes de iniciar el dibujado de cada fotograma.

---

## 6. Hilo de Supervisión (Watchdog)

Para diagnosticar posibles bloqueos en el motor emulado:
- Un hilo supervisor en segundo plano monitoriza el tiempo de ejecución de cada fotograma.
- Si un fotograma tarda más de 2.0 segundos en completarse (síntoma de un posible interbloqueo o bucle sin fin en el código de 32 bits), el supervisor registra en Logcat:
  - El contador de programa actual (`PC`).
  - El puntero de pila (`SP`).
  - El estado de los registros de la CPU invitada (`r0`–`r15`).
  - La última llamada HLE procesada.

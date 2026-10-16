# Capa de Compatibilidad y Emulación HLE: GunBros ARM64 Bridge

## 1. Visión General

La capa de compatibilidad (`include/gunbros/compatibility/`, `src/compatibility/` y `src/emulator/hle_dispatcher.c`) hace posible la ejecución del binario original de 32 bits `libandroidplatform.so` en Android moderno sin tener acceso al código fuente del juego. 

Combina tres mecanismos fundamentales:
1. **Parches Binarios en Memoria**: Modificación en caliente de instrucciones ARM32 específicas para corregir bloqueos por servidores antiguos y adaptar el juego al hardware contemporáneo.
2. **Entorno JNI Emulado**: Estructuras sintéticas en el espacio de memoria invitado que simulan llamadas a la máquina virtual Java de Android.
3. **Despacho HLE (High-Level Emulation)**: Intercepción de 178 funciones de sistema y gráficos redirigidas a rutinas nativas optimizadas de 64 bits.

---

## 2. Parches Binarios en Memoria (`game_patches.c`)

Inmediatamente después de que el cargador ELF (`elf_loader.c`) mapea los segmentos en memoria y antes de que se ejecuten los constructores estáticos del juego, la función `game_patches_apply_all()` aplica parches en las siguientes direcciones de memoria:

| ID | Dirección Virtual | Código Original | Código Parcheado | Componente / Propósito |
| :--- | :--- | :--- | :--- | :--- |
| **A** | `0x00366878` | `0x0affffc8` (`beq`) | `0xe1a00000` (`nop`) | **Bypass de Servidor de Recursos**: Evita un bucle infinito en `CResourceLoader::LoadNext` que esperaba respuesta de servidores Glu extintos. |
| **B** | `0x001fd450` | Varios | Rutina multi-pointer | **Multitáctil de Doble Palanca**: Adapta el control táctil para gestionar punteros independientes para mover y disparar simultáneamente. |
| **C** | `0x0021be00` | Desreferencia directa | Guarda de rango | **Estabilidad de Esqueleto 3D**: `CMesh::GetNodeAt` añade comprobación de límites para prevenir fallos de segmentación por huesos no definidos. |
| **D** | `0x0021b330` | Lógica de tiempo | Clamping de tiempo | **Pantallas de Alta Frecuencia (90Hz / 120Hz)**: Evita división por cero o saltos temporales negativos en `CMesh::GetInterpolationValues`. |
| **E** | `0x002c918c` | Matriz directa | Matriz traspuesta | **Orientación de Fogonazo de Arma**: Corrige la orientación del modelo 3D de fogonazo en `CGun` para que coincida con el cañón. |
| **J** | `0x0037a4e8` | Bucle de sondeo de red | `0xe3a00000` (`mov r0, #0`)<br>`0xe12fff1e` (`bx lr`) | **Bypass de Red GameSpy**: Elude la conexión obligatoria a servidores de emparejamiento GameSpy extintos (`peerchat.gamespy.com`), permitiendo jugar en solitario de forma inmediata. |

### Stubs y Helpers Auxiliares (`guest_helpers_bin.h`)
En la región de memoria virtual `0x8000d000` se inyectan rutinas en código máquina ARM32 compiladas (460 bytes) para proporcionar algoritmos que requieren ejecutarse en el espacio de llamadas del guest (como `qsort`/`heapsort` con callbacks ARM32) y soporte de desenrollado de pila (*stack unwinding*).

> [!NOTE]
> **Procedencia del blob:** El código fuente original (.c/.s) de este helper no está versionado en el repositorio y solo se conserva en forma de array de bytes en `guest_helpers_bin.h`. De acuerdo con las normas de integridad del proyecto, no se reconstruye artificialmente; queda catalogado como pendiente de aportación por el autor del proyecto en el informe de revisión.

---

## 3. Máquina Virtual JNI Sintética (`jni_virtual_machine.c`)

El motor de GunBros realiza frecuentes consultas a través de JNI hacia Android para consultar datos como el idioma del sistema, país, estado de la red y dimensiones de la pantalla. Si cada una de estas consultas requiriera enlazar con la JVM de Android y buscar métodos Java dinámicamente mediante reflexión, el rendimiento se degradaría notablemente.

Para optimizar esto, el bridge aprovisiona estructuras sintéticas directamente en la memoria virtual emulada:
- **`GUEST_JVM_OBJ`** (`0x60000100`): Estructura `JavaVM` emulada apuntando a `GUEST_JVM_VTABLE` (`0x60000120`).
- **`GUEST_ENV_OBJ`** (`0x60001000`): Estructura `JNIEnv` emulada apuntando a `GUEST_ENV_VTABLE` (`0x60001100`).

### Métodos Simulados
Cuando el código emulado invoca métodos a través de `CallObjectMethod` o `CallIntMethod`:
- `getLanguage`: Devuelve una cadena con valor `"en"`.
- `getCountry`: Devuelve una cadena con valor `"US"`.
- `getDeviceModel`: Devuelve `"Modern Android ARM64"`.
- `isNetworkAvailable`: Devuelve `1` (verdadero).
- `getDirectBufferAddress`: Devuelve la dirección de host correspondiente al búfer de memoria.

---

## 4. Despacho de Alto Nivel (HLE) (`hle_dispatcher.c`)

El despachador HLE intercepta 178 llamadas del sistema y funciones de bibliotecas externas invocadas a través de la tabla PLT del ELF.

### 4.1. Operaciones de Memoria y Cadenas
- **Asignación**: `malloc`, `free`, `realloc`, `calloc` se traducen hacia el gestor de memoria dinámica del emulador.
- **Cadenas y Búferes**: `memcpy`, `memmove`, `memset`, `strlen`, `strcpy`, `strcmp`, `snprintf` se ejecutan a velocidad nativa en la CPU de 64 bits con validación previa de punteros.

### 4.2. Operaciones de Archivos
- `fopen`, `fclose`, `fread`, `fwrite`, `fseek`, `ftell`, `stat`, `remove`, `rename`, `opendir`, `readdir`, `closedir`, `mkdir`, `rmdir` se enrutan de forma unificada hacia el subsistema `gunbros/filesystem`.

### 4.3. Gráficos OpenGL ES 1.1 y Extensiones
- **Llamadas Base**: `glViewport`, `glClear`, `glBindTexture`, `glDrawArrays`, `glDrawElements`, `glEnable`, `glDisable`, etc., se reenvían al contexto OpenGL ES 1.1 CM nativo.
- **Extensiones OES para Modelos 3D**: GunBros utiliza extensiones de matriz de paleta de huesos para animaciones de personajes. Se implementan manejadores para:
  - `glCurrentPaletteMatrixOES`
  - `glMatrixIndexPointerOES`
  - `glWeightPointerOES`
  - `glClipPlanex` y variantes en punto fijo (`x`)

### 4.4. Adaptación a Pantallas Ultrapanorámicas (Letterboxing)
En dispositivos contemporáneos con pantallas 20:9 o 21:9 (por ejemplo, resoluciones 2400x1080 o 2772x1240), el juego original (diseñado para 800x480) sufriría deformaciones o elementos fuera del encuadre.

El despachador intercepta `glViewport` y `glScissor` aplicando una transformación afín:
$$\text{host\_x} = \text{vp\_x} + \left( \frac{\text{guest\_x} \times \text{vp\_w}}{\text{guest\_screen\_w}} \right)$$
$$\text{host\_y} = \text{vp\_y} + \left( \frac{\text{guest\_y} \times \text{vp\_h}}{\text{guest\_screen\_h}} \right)$$

Las bandas negras laterales son limpiadas mediante `glClear(GL_COLOR_BUFFER_BIT)` sobre la superficie física completa antes de iniciar el dibujado de cada fotograma.

---

## 5. Hilo de Supervisión (Watchdog)

Para diagnosticar posibles bloqueos en el motor emulado:
- Un hilo supervisor en segundo plano monitoriza el tiempo de ejecución de cada fotograma.
- Si un fotograma tarda más de 2.0 segundos en completarse (síntoma de un posible interbloqueo o bucle sin fin en el código de 32 bits), el supervisor registra en Logcat:
  - El contador de programa actual (`PC`).
  - El puntero de pila (`SP`).
  - El estado de los registros de la CPU invitada (`r0`–`r15`).
  - La última llamada HLE procesada.

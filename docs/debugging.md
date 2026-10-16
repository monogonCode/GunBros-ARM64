# Guía de Depuración y Diagnóstico: GunBros ARM64 Bridge

Esta guía describe cómo analizar, depurar y solucionar incidencias durante la ejecución de GunBros en dispositivos Android modernos.

---

## 1. Sistema de Registro en Tiempo Real (Logcat)

El bridge nativo emite mensajes estructurados a través del subsistema de logging de Android. Se han definido etiquetas (*tags*) especializadas para aislar los diferentes componentes:

| Etiqueta (Tag) | Nivel Típico | Responsabilidad y Contenido |
| :--- | :--- | :--- |
| **`GunBros`** | `INFO` / `WARN` | Ciclo de vida general, inicialización del bridge, resolución de pantalla y eventos táctiles. |
| **`GunBrosFS`** | `DEBUG` / `INFO` | Auditoría exhaustiva de I/O: llamadas `fopen`, `fread`, `fwrite`, `rename`, `remove`, `stat`, rutas normalizadas y valores de `errno`. |
| **`GunBrosHLE`** | `DEBUG` / `WARN` | Intercepción de funciones de la biblioteca Bionic, rutinas no implementadas y llamadas OpenGL ES. |
| **`GunBrosDyn`** | `INFO` / `ERROR` | Estado de Dynarmic, compilación de bloques JIT, trampas SVC y excepciones del procesador emulado. |
| **`GLU`** | `INFO` | Mensajes impresos internamente por el motor original de Glu Mobile. |

---

## 2. Captura y Filtrado de Logs

### 2.1. Script Automatizado
Para iniciar una captura continua de logs limpia y guardarla en un archivo con marca de tiempo:
```bash
./scripts/collect-logs.sh
```
El archivo de log se guardará automáticamente en `logs/gunbros_YYYYMMDD_HHMMSS.log`.

### 2.2. Comandos Manuales con ADB
Si deseas filtrar únicamente las operaciones de archivos en tiempo real:
```bash
adb logcat -s GunBrosFS:V
```

Para ver la ejecución general del bridge y posibles errores de Android:
```bash
adb logcat -v time GunBros:V GunBrosFS:V GunBrosHLE:V GunBrosDyn:V AndroidRuntime:E *:S
```

Para limpiar el búfer de Logcat antes de una nueva sesión:
```bash
adb logcat -c
```

---

## 3. Inspección de Archivos Guardados en el Dispositivo

Los archivos generados por el juego se almacenan en el directorio privado de la aplicación:
```
/storage/emulated/0/Android/data/com.glu.android.gunbros_free/files/
```

### 3.1. Listar Archivos Creados por el Juego
```bash
adb shell ls -la /storage/emulated/0/Android/data/com.glu.android.gunbros_free/files/
```
En una ejecución típica, deberías ver archivos como:
- `prefs.dat` (opciones del juego y audio).
- `savegame.dat` (archivo principal de guardado).
- `-1_1000` a `-1_1019` (almacenes de perfiles y estadísticas).
- `-1_PDST` (estado de persistencia del jugador).

### 3.2. Descargar los Archivos al Ordenador para Análisis
```bash
mkdir -p ./dump_savegame
adb pull /storage/emulated/0/Android/data/com.glu.android.gunbros_free/files/ ./dump_savegame/
```

### 3.3. Sobrescribir una Partida de Prueba
```bash
adb push ./mi_partida/savegame.dat /storage/emulated/0/Android/data/com.glu.android.gunbros_free/files/savegame.dat
```

---

## 4. Diagnóstico de Cuelgues y Watchdog

Si la emulación se detiene o un fotograma se congela durante más de 2 segundos, el **hilo supervisor (Watchdog)** imprime un volcado de diagnóstico en Logcat bajo la etiqueta `GunBros`:

```text
E GunBros : [WATCHDOG] Frame execution stalled! Exceeded 2.0s timeout.
E GunBros : [WATCHDOG] Guest PC: 0x0037a4e8  Guest SP: 0x707ffec0
E GunBros : [WATCHDOG] Register Dump:
E GunBros :   r0: 0x00000000   r1: 0x6004b120   r2: 0x00000004   r3: 0x00000001
E GunBros :   r4: 0x6004b100   r5: 0x00000000   r6: 0x004c9658   r7: 0x00000000
E GunBros :   r8: 0x00000000   r9: 0x00000000  r10: 0x00000000  r11: 0x707ffef0
E GunBros :  r12: 0x80001234   lr: 0x00366880  cpsr: 0x60000010
```

### Cómo Interpretar el Volcado:
- **`Guest PC`**: Indica la dirección de instrucción ARM32 en la que el código quedó atrapado. Puedes cotejar esta dirección abriendo `libandroidplatform.so` en herramientas de desensamblado como **Ghidra**, **IDA Pro** o **Rizin** para identificar qué función está en ejecución.
- Si el PC apunta a `0x8000xxxx`, la ejecución se encontraba dentro de un stub de llamada HLE. Revisa `hle_dispatcher.c` para identificar qué llamada de sistema no devolvió el control.

---

## 5. Problemas Frecuentes y Soluciones

### 5.1. "Failure [INSTALL_FAILED_DEPRECATED_SDK_VERSION]"
- **Causa**: Android 14, 15 y 16 restringen por defecto la instalación de aplicaciones diseñadas para versiones antiguas de Android.
- **Solución**: Instala utilizando el parámetro `--bypass-low-target-sdk-block`:
  ```bash
  adb install --no-incremental --bypass-low-target-sdk-block -r -d GunBros_Android16_Dynarmic.apk
  ```

### 5.2. Pantalla Negra tras el Logo Inicial
- **Causa**: Fallo en la creación de la superficie EGL o context mismatch de OpenGL ES 1.1 CM.
- **Diagnóstico**: Revisa Logcat buscando errores con la etiqueta `EGL` o `GunBros`:
  ```bash
  adb logcat -s GunBros:E EGL_emulation:E
  ```
- **Solución**: Asegúrate de que el dispositivo soporte OpenGL ES 1.1 CM o que el driver del fabricante exponga extensiones OES requeridas.

### 5.3. Los Controles Táctiles no Responden en los Extremos de la Pantalla
- **Causa**: Desfase en la transformación de coordenadas debido al formato ultrapanorámico (20:9 o 21:9).
- **Solución**: El módulo `android_window.c` calcula automáticamente los márgenes de bandas negras (*letterboxing*). Verifica que `android_window_translate_touch` esté recibiendo las dimensiones físicas correctas de la ventana.

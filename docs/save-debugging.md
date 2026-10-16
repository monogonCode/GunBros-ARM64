# Protocolo de Depuración de Persistencia (Save Debugging)

Este protocolo permite diagnosticar y aislar de forma determinista cualquier problema relacionado con la persistencia del progreso del juego (`savegame.dat`, `prefs.dat`, `-1_1000..-1_1019`) en GunBros ARM64.

---

## Requisitos Previos

- Dispositivo Android con depuración USB / ADB habilitada.
- Script de captura de registros: `./scripts/collect-logs.sh`.
- APK compilado con el flag `BRIDGE_DEBUG` habilitado en CMake / compilación.

---

## Protocolo Paso a Paso

### Paso 1: Compilación con `BRIDGE_DEBUG` y Preparación de Logging

1. Compila el proyecto con soporte de depuración habilitado:
   ```bash
   ./scripts/build.sh
   ```
2. Instala el APK en el dispositivo:
   ```bash
   ./scripts/deploy.sh
   ```
3. Inicia la captura continua de registros con `collect-logs.sh`:
   ```bash
   ./scripts/collect-logs.sh
   ```
   *(Este script filtrará las etiquetas `GunBrosARM64` y `GunBrosFS` y guardará la salida en `logs/gunbros_<timestamp>.log`).*

---

### Paso 2: Sesión 1 — Escritura de Progreso Inicial

1. Abre el juego en el dispositivo.
2. Juega una partida corta o compra un artículo en la tienda (cambia monedas / equipamiento).
3. Sal del juego de forma ordenada (o minimízalo y ciérralo desde la vista de tareas recientes).
4. Extrae la carpeta completa de datos del juego a tu equipo local:
   ```bash
   adb pull /sdcard/Android/data/com.glu.android.gunbros_free/files session1_files/
   ```
5. Calcula y guarda los hashes SHA-256 de cada archivo generado:
   ```bash
   sha256sum session1_files/* > session1_checksums.txt
   cat session1_checksums.txt
   ```

---

### Paso 3: Sesión 2 — Carga en Frío sin Modificaciones

1. Abre nuevamente el juego desde el lanzador, **sin tocar nada** en la tienda ni alterar el inventario.
2. Espera a que cargue el menú principal o la pantalla de selección de personaje.
3. Sal del juego completamente.
4. Extrae nuevamente la carpeta de archivos a un directorio separado:
   ```bash
   adb pull /sdcard/Android/data/com.glu.android.gunbros_free/files session2_files/
   ```
5. Calcula los nuevos hashes SHA-256:
   ```bash
   sha256sum session2_files/* > session2_checksums.txt
   cat session2_checksums.txt
   ```

---

### Paso 4: Diagnóstico y Análisis de Hipótesis

Compara los hashes entre la Sesión 1 y la Sesión 2 (`diff -u session1_checksums.txt session2_checksums.txt`):

#### Escenario A: Los archivos cambiaron entre la Sesión 1 y la Sesión 2
- **Diagnóstico**: El juego leyó los archivos pero falló en la validación de integridad o formato interno, interpretó el guardado como corrupto o no coincidente, y los sobrescribió con valores por defecto al arrancar.
- **Acción requerida**:
  - Revisa en los logs las trazas `[FS:SAVE:fread]` (comprobar si `req == got` o si se produjeron lecturas truncadas).
  - Revisa `[FS:SAVE:fseek]` y comprueba si los offsets son negativos (p. ej. `SEEK_END` o saltos hacia atrás).
  - Revisa `[FS:SAVE:stat]` para confirmar que el tamaño reportado coincida exactamente con el archivo físico y que la fecha de modificación (`st_mtime`) sea consistente.

#### Escenario B: Los archivos NO cambiaron (hashes idénticos)
- **Diagnóstico**: El motor del juego nunca intentó leer los archivos existentes al arrancar, o la ruta de lectura fue rechazada antes de llegar al sistema de archivos POSIX.
- **Acción requerida**:
  - Busca en el log si existe alguna llamada `[FS:SAVE:fopen]` con modo `"rb"` sobre `savegame.dat` o `prefs.dat` al iniciar la aplicación.
  - Comprueba si aparece alguna llamada `[BRIDGE_DEBUG:JNI] OpenAPKFile called for 'data:savegame.dat'`, lo que indicaría que el motor intentó abrir el archivo a través de la capa de recursos Java en lugar de la capa de archivos locales.

---

### Paso 5: Comparación de Hexdumps

1. Compara byte a byte los archivos de guardado entre ambas sesiones:
   ```bash
   xxd session1_files/savegame.dat > s1_save.hex
   xxd session2_files/savegame.dat > s2_save.hex
   diff -u s1_save.hex s2_save.hex
   ```
2. Revisa en el log las líneas generadas por `[FS:SAVE:HEXDUMP]` durante `fclose` con modo `wb`:
   ```text
   [FS:SAVE:HEXDUMP] path='/.../files/savegame.dat' size=1024 first_64_bytes: 47 55 4e 42 ...
   ```
3. Utiliza los primeros 64 bytes para identificar si el archivo contiene un encabezado mágico (`GUNB`, etc.), marcas de versión, o si los datos se encuentran en texto plano o cifrados.

# Golden Save Tests

Este directorio contiene el ejecutable de prueba `golden_save_runner` y la documentación para validar volcados de guardado reales de **Gun Bros** contra la capa HLE de archivos.

## Política del Repositorio (Regla 5)

En conformidad con las normas de propiedad intelectual del proyecto:
- **NO se distribuyen ni suben al repositorio** volcados de guardado propietarios (`savegame.dat`, `prefs.dat`, `-1_1000..-1_1019`), assets ni código del juego.
- Cuando no hay un archivo de guardado presente en este directorio, `golden_save_runner` se ejecuta en modo informativo y pasa con éxito.

## Cómo Aportar un Guardado Real para Verificación

Si dispones de un dispositivo Android o emulador ejecutando el juego original o el puente:

1. **Localizar los archivos de guardado en el dispositivo:**
   ```bash
   adb shell run-as com.glu.android.gunbros_free ls -l /data/data/com.glu.android.gunbros_free/files/
   ```

2. **Extraer `savegame.dat` y `prefs.dat`:**
   ```bash
   adb exec-out run-as com.glu.android.gunbros_free cat files/savegame.dat > tests/golden/savegame.dat
   adb exec-out run-as com.glu.android.gunbros_free cat files/prefs.dat > tests/golden/prefs.dat
   ```

3. **Verificar sus hashes SHA-256:**
   ```bash
   sha256sum tests/golden/savegame.dat tests/golden/prefs.dat
   ```

4. **Ejecutar el runner:**
   ```bash
   # Vía test suite completa:
   ./scripts/run_tests.sh

   # O ejecutando el binario directamente con cualquier archivo:
   ./build/host/golden_save_runner tests/golden/savegame.dat
   ./build/host/golden_save_runner tests/golden/prefs.dat
   ```

## Secuencia Reproducida por el Runner

El runner replica exactamente las llamadas a libc/POSIX emitidas por el código ARM32 invitado:
1. `h_stat`: Comprueba la existencia y obtiene el tamaño exacto con el layout de 104 bytes de bionic ARM32.
2. `h_fopen`: Abre en modo lectura binaria (`"rb"`).
3. `h_fseek`: Desplaza el cursor al final (`SEEK_END`) con offset 0.
4. `h_ftell`: Verifica que la posición devuelta coincida exactamente con el tamaño obtenido por `stat`.
5. `h_fseek`: Rebobina al inicio (`SEEK_SET`).
6. `h_fread`: Lee el contenido en memoria del guest y genera un volcado hexadecimal de los primeros 64 bytes.
7. `h_fclose`: Cierra el descriptor.
8. Flujo de guardado seguro (`SafeWriteFile`): escribe en archivo temporal (`"wb"`), valida escritura y renombra atómicamente.

# Sistema de Archivos y Persistencia: GunBros ARM64 Bridge

## 1. El Reto del Almacenamiento en Android Moderno

En la época de Android 2.x a 4.x, las aplicaciones tenían acceso de lectura y escritura prácticamente irrestricto sobre la memoria externa (`/sdcard/` o `/mnt/sdcard/`) y las rutas internas (`/data/data/<package>/`). El motor de GunBros fue programado asumiendo estas rutas fijas.

A partir de Android 10 y de forma estricta en Android 11 a 16, el sistema operativo implementa **Scoped Storage** y políticas estrictas de **SELinux**:
- Las aplicaciones no pueden crear ni modificar archivos arbitrarios en la raíz de `/sdcard/`.
- Cualquier intento de acceder directamente a rutas obsoletas sin pasar por la capa de compatibilidad resulta en denegación de permisos (`EACCES`) o ruta no encontrada (`ENOENT`).
- Los procesos en segundo plano son congelados de forma agresiva por el sistema operativo (*Cached App Freezer*), lo que descarta cualquier búfer de memoria de usuario (`stdio`) que no se haya volcado explícitamente a disco mediante llamadas del sistema.

Para resolver esto sin modificar el código fuente original del juego, el subsistema de sistema de archivos (`src/filesystem/`) emula una capa POSIX completa con redirección transparente de rutas.

---

## 2. Normalización y Mapeo de Rutas (`path_mapper`)

Todas las llamadas de entrada que involucran rutas de archivos (`fopen`, `stat`, `remove`, `rename`, `mkdir`, `opendir`, `rmdir`) son procesadas por la función `path_mapper_normalize()`.

### Reglas de Transformación Aplicadas

1. **Redirección a Almacenamiento Privado de la Aplicación**:
   Cualquier ruta que haga referencia a `/sdcard/glu/gunbros/`, `/data/data/com.glu.android.gunbros_free/files/` o nombres de archivo relativos se redirige al directorio de archivos privado de la aplicación:
   ```
   /sdcard/glu/gunbros/savegame.dat -> <APP_EXTERNAL_FILES_DIR>/files/savegame.dat
   ```
   Si el almacenamiento externo no está disponible, se utiliza como respaldo el directorio interno (`<APP_INTERNAL_FILES_DIR>/files/`).

2. **Detección y Eliminación de Esquemas Virtuales de Glu**:
   El motor de Glu Mobile utiliza esquemas de protocolo virtual para referirse a diferentes ubicaciones:
   - `data:` -> Directorio de datos del juego.
   - `temp:` -> Directorio de archivos temporales.
   - `cache:` -> Caché del motor.
   - `apk:` -> Archivos empaquetados en el APK.

   En el código C++ del juego, las cadenas de ruta a menudo se concatenan con el directorio base antes de llamar a funciones del sistema operativo, resultando en rutas híbridas como:
   ```
   <APP_DIR>/files/data:/prefs.dat
   <APP_DIR>/files/temp:/temp.dat
   ```
   El núcleo de Linux interpretaría `data:` como una subcarpeta que no existe en el sistema de archivos, provocando un fallo `ENOENT` (Error 2: No such file or directory).
   El normalizador detecta la presencia de estos esquemas y extrae el nombre de archivo real, asegurando que la ruta apunte directamente a:
   ```
   <APP_DIR>/files/prefs.dat
   ```

3. **Corrección de Prefijo en Archivos de Recursos (`ackTOC`)**:
   En el motor de Glu, un fallo histórico de manipulación de cadenas recortaba el primer carácter de los archivos de tabla de contenidos de paquetes (`packTOC_*.dat`). Si el juego solicita un archivo cuyo nombre comienza con `ackTOC`, el normalizador le antepone automáticamente la letra `p` faltante (`packTOC`), permitiendo la carga fluida de texturas y sonidos.

4. **Sustitución Automática de Resolución (WVGA a XGA)**:
   Si el juego solicita un atlas de texturas para resolución WVGA (`_wvga.png`) que no está presente en los datos instalados, el mapeador comprueba la existencia de la variante en alta definición XGA (`_xga.png`) y redirige la apertura sin que el motor falle.

---

## 3. Mecánica del Guardado Atómico en GunBros

Mediante ingeniería inversa y desensamblado de la biblioteca `libandroidplatform.so`, se identificó la rutina de persistencia principal en las funciones `CSaveGameMgr::Write`, `COptionsMgr::Write` y `CFileUtil::SafeWriteApplicationSaveGameFile`.

El juego emplea un patrón de escritura atómica para evitar que un fallo de energía o cierre inesperado corrompa los archivos originales:

```
[Paso 1] fopen("temp.dat", "wb")
               |
               v
[Paso 2] fwrite(datos_actualizados) -> fflush() -> fclose()
               |
               v
[Paso 3] remove("data:/savegame.dat")    (o prefs.dat)
               |
               v
[Paso 4] rename("temp.dat", "data:/savegame.dat")
```

Si en el Paso 3 o 4 la ruta no estuviera normalizada o los permisos fallaran, el archivo `temp.dat` quedaría huérfano y el archivo definitivo `savegame.dat` sería eliminado o no se actualizaría.

---

## 4. Tabla Virtual de Descriptores (`file_handles`)

El código emulado de 32 bits espera trabajar con identificadores numéricos de archivo o punteros `FILE*`. Devolver punteros nativos directos o descriptores de archivo crudos del sistema operativo anfitrión puede provocar graves fallos si el código invitado realiza operaciones indebidas o asume valores de 32 bits.

La capa de archivos implementa una **tabla virtual de descriptores**:
- Asigna identificadores enteros del `1` al `64` (`GUNBROS_MAX_OPEN_FILES`).
- Cada ranura almacena el puntero nativo `FILE*`, el modo de apertura (`"rb"`, `"wb"`, etc.), la ruta original y la ruta normalizada.
- Las ranuras `0` (stdin), `1` (stdout) y `2` (stderr) del host quedan completamente protegidas; ninguna operación del juego puede cerrar ni sobreescribir las salidas estándar del sistema.
- Se implementan guardas de seguridad contra cierres dobles (*double-close protection*).

---

## 5. Vaciado Forzado a Disco (`file_operations`)

La biblioteca estándar de C (`stdio`) utiliza búferes en memoria de usuario para optimizar las escrituras. Sin embargo, en dispositivos móviles, el usuario puede cambiar de aplicación o cerrar el juego mediante el menú de aplicaciones recientes en cualquier momento.

Para evitar la pérdida de bloques que aún no han sido enviados físicamente al almacenamiento flash:
1. `gunbros_fwrite()` invoca automáticamente `fflush()` tras cada operación de escritura.
2. `gunbros_fclose()` realiza un `fflush()` final antes de invocar `fclose()` en el sistema operativo anfitrión.

---

## 6. Estado Actual de la Persistencia del Progreso

### Lo que Funciona Correctamente
- Las operaciones a nivel de sistema operativo y kernel (`fopen`, `fwrite`, `fflush`, `remove`, `rename`) están completamente verificadas y funcionan sin errores en dispositivos reales con Android moderno.
- Los archivos de configuración (`prefs.dat`), archivos temporales y los contenedores de perfiles de usuario (`-1_1000` a `-1_1019`, `-1_PDST`) se crean, escriben y renombran atómicamente en la carpeta de la aplicación con confirmación de éxito:
  ```
  [FS:rename] SUCCESS '/storage/.../files/temp.dat' -> '/storage/.../files/prefs.dat'
  [FS:fopen] SUCCESS slot=1 mode='wb' path='/storage/.../files/-1_1000'
  ```
- La suite de pruebas de persistencia entre procesos independientes (`tests/filesystem/test_persistence.c`) supera el 100% de las verificaciones.

### Problema Pendiente a Investigar (Lógica Interna del Juego)
A pesar de que los archivos se guardan físicamente en el almacenamiento del dispositivo, al reiniciar la aplicación por completo, el motor del juego reinicia el progreso visible del jugador (monedas, armas compradas y nivel de campaña vuelven a los valores por defecto).

### Hipótesis Técnicas para Colaboradores e Investigadores

Si deseas contribuir a solucionar la persistencia del progreso, estas son las áreas clave identificadas durante la ingeniería inversa:

1. **Dependencia de la Identidad del Dispositivo / Cifrado de Guardado**:
   - Muchos títulos de Glu Mobile de esta generación derivaban una clave de cifrado XOR o AES para `savegame.dat` a partir de datos del dispositivo devueltos por llamadas JNI:
     - `TelephonyManager.getDeviceId()` (IMEI)
     - `WifiInfo.getMacAddress()`
     - `Settings.Secure.ANDROID_ID`
   - En nuestra capa de emulación (`jni_virtual_machine.c`), estos valores devuelven respuestas sintéticas predefinidas. Si el valor devuelto no es consistente o si el motor detecta un cambio en algún parámetro de la máquina, considera que la partida pertenece a otro dispositivo y la descarta.

2. **Detección de Archivo No Válido y Reinicio Forzado en `CSaveGameMgr::Read`**:
   - En la dirección virtual `0x00252b90` se encuentra la rutina de lectura del archivo de guardado.
   - Si la lectura falla, si el tamaño del archivo no coincide con el encabezado esperado, o si el checksum interno no concuerda, el motor bifurca inmediatamente a `0x00252cc4`, donde ejecuta:
     1. `CSaveGameMgr::Reset()` (borra todos los valores en memoria).
     2. `CSaveGameMgr::Write()` (sobrescribe el archivo en disco con la partida reiniciada).
   - Se recomienda desensamblar y colocar puntos de registro (*trace logging*) en `0x00252b90` a `0x00252cf0` para observar exactamente qué condición provoca la bifurcación al reinicio.

3. **Verificación de Metadatos de Archivo (`stat`)**:
   - El juego realiza llamadas a `stat` para verificar la fecha de modificación (`st_mtime`) o el tamaño de `savegame.dat`. Asegurar que los campos de la estructura `stat` de 32 bits devueltos por `hle_dispatcher.c` coincidan exactamente con la estructura de Bionic de Android 2.x.

---

## 7. Diagnóstico y Auditoría en Tiempo Real

Todas las operaciones del sistema de archivos emiten registros detallados en Logcat bajo la etiqueta `GunBrosFS`:

```bash
adb logcat -s GunBrosFS
```

Ejemplo de salida de auditoría durante la ejecución:
```text
I GunBrosFS: [FS:fopen] SUCCESS slot=1 mode='wb' path='/storage/.../files/temp.dat' (orig='data:/temp.dat')
I GunBrosFS: [FS:fwrite] slot=1 requested=1024 written=1024 flushed=OK
I GunBrosFS: [FS:fclose] slot=1 closed OK
I GunBrosFS: [FS:remove] SUCCESS '/storage/.../files/prefs.dat'
I GunBrosFS: [FS:rename] SUCCESS '/storage/.../files/temp.dat' -> '/storage/.../files/prefs.dat'
```

# Guía de Pruebas Automatizadas: GunBros ARM64 Bridge

Este documento detalla la suite de pruebas unitarias y de integración que valida la robustez, el aislamiento y la seguridad de los diferentes subsistemas sin necesidad de disponer de un dispositivo Android físico.

---

## 1. Filosofía de Pruebas

Un principio fundamental de este proyecto es que **ninguna refactorización o cambio de código se considera correcto hasta haber sido verificado mediante pruebas automatizadas**.

Las pruebas están diseñadas para:
1. **Ejecutarse en el host**: Compilan y corren directamente en la máquina de desarrollo (Linux, macOS, WSL2) utilizando cualquier compilador moderno (GCC o Clang).
2. **Aislar responsabilidades**: Prueban componentes individuales de forma independiente (sistema de archivos, memoria virtual, búferes de audio).
3. **Simular ciclos de vida reales**: Incluyen pruebas multiproceso para certificar la persistencia de datos en almacenamiento ante cierres forzados de la aplicación.

---

## 2. Catálogo de Pruebas Disponibles

La suite de pruebas consta de 5 ejecutables gestionados a través de **CTest**:

```
+-------------------------------------------------------------------------------+
|                            Suite de Pruebas CTest                             |
+-------------------------------------------------------------------------------+
  |-- test_path_mapper       : Normalización de rutas, esquemas Glu y reglas TOC
  |-- test_file_operations   : Handles virtuales, autoflush, fseek, mkdir, rmdir
  |-- test_persistence       : Persistencia atómica de guardado entre dos procesos
  |-- test_pcm_ring          : Ring buffer de audio lock-free y cruce de límites
  |-- test_guest_memory      : Asignación virtual, commpage y conversión de punteros
```

### 2.1. `test_path_mapper` (`tests/filesystem/test_path_mapper.c`)
Valida el motor de resolución de rutas:
- Comprueba que punteros nulos o cadenas vacías devuelvan rutas válidas y seguras por defecto.
- Verifica la redirección automática de rutas relativas hacia el directorio privado de la aplicación.
- Verifica la eliminación de esquemas virtuales de Glu (`data:`, `temp:`, `cache:`, `apk:`) tanto en solitario como cuando han sido concatenados con prefijos de directorio.
- Comprueba la restitución del carácter `p` en archivos `ackTOC` (`ackTOC_*.dat` -> `packTOC_*.dat`).
- Comprueba la resolución de respaldo de texturas WVGA a XGA cuando el asset original no existe.

### 2.2. `test_file_operations` (`tests/filesystem/test_file_operations.c`)
Valida la tabla virtual de descriptores de archivo y las operaciones de entrada/salida:
- Asigna descriptores seguros en el rango `1` al `64`, certificando que los descriptores `0`, `1` y `2` del sistema operativo no son alterados.
- Verifica que las escrituras ejecuten `fflush()` inmediato.
- Valida el posicionamiento con `fseek()` y lectura con `ftell()`.
- Comprueba la guarda contra cierres dobles (*double-close safety*).
- Valida la creación recursiva de subdirectorios mediante `gunbros_mkdir()`.
- Verifica el ciclo de vida de directorios (`opendir`, `closedir`, `rmdir`).

### 2.3. `test_persistence` (`tests/filesystem/test_persistence.c`)
Prueba de integración crítica que simula el ciclo de vida real de dos sesiones del juego:
1. **Proceso 1 (Sesión de Juego)**:
   - Abre un archivo `temp.dat` en modo escritura.
   - Escribe una estructura simulada de guardado con monedas, estrellas y armas.
   - Aplica `fflush()` y cierra el archivo.
   - Elimina `savegame.dat` y renombra `temp.dat` a `savegame.dat`.
   - El proceso termina de forma limpia.
2. **Proceso 2 (Reinicio en Frío)**:
   - Se inicia un nuevo proceso independiente desde la línea de comandos.
   - Intenta abrir `savegame.dat` en modo lectura.
   - Valida byte a byte la integridad de todos los campos de la estructura de datos.

### 2.4. `test_pcm_ring` (`tests/platform/test_pcm_ring.c`)
Valida el búfer circular lock-free SPSC de 64 KB para audio:
- Escribe bloques de muestras de audio simuladas.
- Verifica que la lectura devuelva exactamente los mismos bytes en orden estricto FIFO.
- Prueba el cruce continuo del puntero por el límite del búfer (*ring wrap-around*).

### 2.5. `test_guest_memory` (`tests/emulator/test_guest_memory.c`)
Valida el mapa de memoria virtual del emulador:
- Comprueba la asignación de memoria anónima (`mmap`) para los rangos de código, heap y pila.
- Valida la conversión bidireccional entre direcciones invitadas de 32 bits y punteros reales del host de 64 bits.
- Verifica la inicialización de los stubs del *commpage* (`__kuser_cmpxchg`) en `0xffff0fc0`.

---

## 3. Cómo Ejecutar las Pruebas

### 3.1. Mediante el Script Automatizado
La forma más sencilla de compilar y correr todas las pruebas:
```bash
./scripts/run_tests.sh
```

### 3.2. Mediante Comandos Manuales de CTest
```bash
# Compilar las pruebas
cmake -B build/host -S . -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON
cmake --build build/host -j$(nproc)

# Ejecutar la suite
ctest --test-dir build/host --output-on-failure --verbose
```

### Ejemplo de Salida Exitosa:
```text
Test project .../build/host
    Start 1: test_path_mapper
1/5 Test #1: test_path_mapper .................   Passed    0.01 sec
    Start 2: test_file_operations
2/5 Test #2: test_file_operations .............   Passed    0.01 sec
    Start 3: test_persistence
3/5 Test #3: test_persistence .................   Passed    0.01 sec
    Start 4: test_pcm_ring
4/5 Test #4: test_pcm_ring ....................   Passed    0.00 sec
    Start 5: test_guest_memory
5/5 Test #5: test_guest_memory ................   Passed    0.00 sec

100% tests passed, 0 tests failed out of 5
Total Test time (real) = 0.04 sec
```

---

## 4. Cómo Añadir Nuevas Pruebas

Si desarrollas una nueva funcionalidad o deseas probar un parche específico:

1. Crea tu archivo de prueba en el directorio apropiado dentro de `tests/`, por ejemplo:
   ```c
   // tests/compatibility/test_my_feature.c
   #include <assert.h>
   #include <stdio.h>

   int main(void) {
       printf("=== Running My Feature Test ===\n");
       assert(1 == 1);
       printf("  [PASS] Feature works correctly!\n");
       return 0;
   }
   ```

2. Registra el nuevo ejecutable en `CMakeLists.txt` dentro del bloque `if(BUILD_TESTING)`:
   ```cmake
   add_executable(test_my_feature tests/compatibility/test_my_feature.c)
   target_link_libraries(test_my_feature PRIVATE gunbros_common)
   add_test(NAME test_my_feature COMMAND test_my_feature)
   ```

3. Vuelve a ejecutar `./scripts/run_tests.sh` para verificar que tu prueba se compile y pase automáticamente junto con las demás.

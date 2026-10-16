# Legacy GunBros Bridge Archive

This directory preserves the historical, pre-refactor source files for auditability, rollback, and reference purposes:

- `arm64_bridge.c` & `bridge_hle_patch.h`: Initial Unicorn-engine-based compatibility bridge prototype. Deprecated due to Unicorn's lack of ARM-on-ARM64 JIT hardware acceleration.
- `arm64_bridge_dynarmic.c`: Initial monolithic 3,136-line bridge implementation combining JNI, Dynarmic invocation, guest memory management, 178 HLE functions, file I/O, audio streaming, and game-specific binary patches. Now modularized into `src/` and `include/gunbros/`.
- `arm64_bridge_dynarmic.cpp`: Early experimental C++ wrapper prototype, superseded by `src/emulator/dynarmic_backend.cpp`.
- `bridge_hle_dynarmic.h`: Monolithic HLE header, replaced by `include/gunbros/emulator/hle_dispatcher.h` and subsystem headers.
- `dynarmic_backend.cpp` & `dynarmic_backend.h`: Superseded by modular equivalents in `src/emulator/` and `include/gunbros/emulator/`.
- `pcm_ring.c` & `pcm_ring.h`: Superseded by modular equivalents in `src/platform/` and `include/gunbros/platform/`.

These files are no longer compiled in modern builds. All active development resides in `src/`, `include/gunbros/`, `tests/`, and `scripts/`.

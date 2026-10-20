# Graph Report - .  (2026-10-19)

## Corpus Check
- Corpus is ~47,093 words - fits in a single context window. You may not need a graph.

## Summary
- 696 nodes · 1584 edges · 60 communities (42 shown, 18 thin omitted)
- Extraction: 72% EXTRACTED · 28% INFERRED · 0% AMBIGUOUS · INFERRED: 444 edges (avg confidence: 0.81)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Filesystem POSIX Operations|Filesystem POSIX Operations]]
- [[_COMMUNITY_OpenGL ES 1.1 Emulation|OpenGL ES 1.1 Emulation]]
- [[_COMMUNITY_HLE ABI and Register Dispatch|HLE ABI and Register Dispatch]]
- [[_COMMUNITY_Audio and Sound Engine|Audio and Sound Engine]]
- [[_COMMUNITY_JNI Platform Exports|JNI Platform Exports]]
- [[_COMMUNITY_Bridge Core Lifecycle|Bridge Core Lifecycle]]
- [[_COMMUNITY_Patch Equivalence Verification|Patch Equivalence Verification]]
- [[_COMMUNITY_Dynarmic CPU Recompiler|Dynarmic CPU Recompiler]]
- [[_COMMUNITY_HLE Syscall Handlers|HLE Syscall Handlers]]
- [[_COMMUNITY_Network and C Runtime Stubs|Network and C Runtime Stubs]]
- [[_COMMUNITY_SHA-256 Hashing|SHA-256 Hashing]]
- [[_COMMUNITY_System Architecture Specification|System Architecture Specification]]
- [[_COMMUNITY_Technical Review and Fixes|Technical Review and Fixes]]
- [[_COMMUNITY_Filesystem and Storage Translation|Filesystem and Storage Translation]]
- [[_COMMUNITY_Testing Framework and Philosophy|Testing Framework and Philosophy]]
- [[_COMMUNITY_CMake Build Targets|CMake Build Targets]]
- [[_COMMUNITY_Binary Compatibility Patches|Binary Compatibility Patches]]
- [[_COMMUNITY_Cross-Compilation and Packaging|Cross-Compilation and Packaging]]
- [[_COMMUNITY_Persistence and Golden Save|Persistence and Golden Save]]
- [[_COMMUNITY_Diagnostics and Troubleshooting|Diagnostics and Troubleshooting]]
- [[_COMMUNITY_Dependency Download Scripts|Dependency Download Scripts]]
- [[_COMMUNITY_SHA-256 Types and Macros|SHA-256 Types and Macros]]
- [[_COMMUNITY_Game Patches Headers|Game Patches Headers]]
- [[_COMMUNITY_JNI Methods Headers|JNI Methods Headers]]
- [[_COMMUNITY_Common Environment Setup|Common Environment Setup]]
- [[_COMMUNITY_Base APK Automation|Base APK Automation]]
- [[_COMMUNITY_Setup Dependency Checks|Setup Dependency Checks]]
- [[_COMMUNITY_Android Build Script|Android Build Script]]
- [[_COMMUNITY_Build Automation Scripts|Build Automation Scripts]]
- [[_COMMUNITY_Log Collection Tool|Log Collection Tool]]
- [[_COMMUNITY_Device Deployment Tool|Device Deployment Tool]]
- [[_COMMUNITY_APK Packaging Tool|APK Packaging Tool]]
- [[_COMMUNITY_Test Execution Runner|Test Execution Runner]]
- [[_COMMUNITY_Project Setup Tool|Project Setup Tool]]
- [[_COMMUNITY_test_patch_equivalence Executable Target|test_patch_equivalence Executable Target]]
- [[_COMMUNITY_test_sha256 Executable Target|test_sha256 Executable Target]]
- [[_COMMUNITY_BRIDGE_DEBUG Traces for Save Operations and OpenAPKFile|BRIDGE_DEBUG Traces for Save Operations and OpenAPKFile]]
- [[_COMMUNITY_Informative Syscall Stubs with LR Logging|Informative Syscall Stubs with LR Logging]]

## God Nodes (most connected - your core abstractions)
1. `hle_t` - 62 edges
2. `guest_to_host()` - 60 edges
3. `JNICALL` - 53 edges
4. `JNIEnv` - 52 edges
5. `jobject` - 52 edges
6. `guest_ptr()` - 42 edges
7. `hle_t` - 33 edges
8. `jint` - 32 edges
9. `hle_t` - 23 edges
10. `run_guest()` - 22 edges

## Surprising Connections (you probably didn't know these)
- `main()` --calls--> `guest_to_host()`  [INFERRED]
  tests/emulator/test_guest_memory.c → src/emulator/guest_memory.c
- `run_guest_save_sequence()` --calls--> `guest_to_host()`  [INFERRED]
  tests/golden/golden_save_runner.c → src/emulator/guest_memory.c
- `write_guest_str()` --calls--> `guest_to_host()`  [INFERRED]
  tests/golden/golden_save_runner.c → src/emulator/guest_memory.c
- `test_fseek_negative_offset()` --calls--> `guest_to_host()`  [INFERRED]
  tests/test_hle_libc.c → src/emulator/guest_memory.c
- `test_sscanf_multi_args()` --calls--> `guest_to_host()`  [INFERRED]
  tests/test_hle_libc.c → src/emulator/guest_memory.c

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Atomic Save and Persistence Pipeline** — docs_filesystem_atomic_save_mechanism, docs_filesystem_virtual_descriptor_table, docs_filesystem_autoflush, docs_review_changes_bionic_stat_104b, golden_readme_guest_io_sequence [INFERRED 0.85]
- **Modular HLE and Dynamic Symbol Resolution** — docs_architecture_hle_dispatch_table, docs_review_changes_hle_modularization, docs_review_changes_dynamic_import_resolution, cmakelists_test_hle_resolution [INFERRED 0.95]
- **Declarative Game Patching and Verification Flow** — docs_architecture_game_patches, docs_compatibility_game_patches_catalog, docs_review_changes_table_driven_patches, cmakelists_test_patch_equivalence [INFERRED 0.95]

## Communities (60 total, 18 thin omitted)

### Community 0 - "Filesystem POSIX Operations"
Cohesion: 0.07
Nodes (64): FILE, gunbros_closedir(), gunbros_mkdir(), gunbros_opendir(), gunbros_readdir(), gunbros_rmdir(), file_handles_alloc(), file_handles_free() (+56 more)

### Community 1 - "OpenGL ES 1.1 Emulation"
Cohesion: 0.06
Nodes (72): guest_mem_read(), guest_mem_write(), guest_to_host(), h_gl_stub(), h_glActiveTexture(), h_glAlphaFunc(), h_glAlphaFuncx(), h_glBindBuffer() (+64 more)

### Community 2 - "HLE ABI and Register Dispatch"
Cohesion: 0.09
Nodes (64): guest_ptr(), hle_float_arg0(), hle_float_arg1(), hle_float_ret(), hle_ret64(), hle_retdouble(), h_atoi(), h_atoll() (+56 more)

### Community 3 - "Audio and Sound Engine"
Cohesion: 0.06
Nodes (57): aaudio_data_callback_result_t, aaudio_result_t, AAudioStream, jni_audio_get_min_buffer_size(), jni_audio_initialise_sound_engine(), jni_audio_mp3_event(), jni_audio_set_volume(), jni_audio_start_audio_stream() (+49 more)

### Community 4 - "JNI Platform Exports"
Cohesion: 0.13
Nodes (63): bridge_touch_push(), Java_com_glu_android_GluBeam_onIncomingNFCDataReceived(), Java_com_glu_android_iap_IAPJava_iapCallbackEvent(), Java_com_glu_platform_android_GluPlatformActivityJNI_feedPCMMediaPlayer(), Java_com_glu_platform_android_GluPlatformActivityJNI_initialise(), Java_com_glu_platform_android_GluPlatformActivityJNI_javaToNativeFacebook(), Java_com_glu_platform_android_GluPlatformActivityJNI_LocalEvent(), Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonDown() (+55 more)

### Community 5 - "Bridge Core Lifecycle"
Cohesion: 0.08
Nodes (52): bridge_audio_mixer(), bridge_init(), bridge_monotonic_ns(), bridge_on_create(), bridge_on_destroy(), bridge_on_draw_frame(), bridge_on_gl_surface_changed(), bridge_on_gl_surface_created() (+44 more)

### Community 6 - "Patch Equivalence Verification"
Cohesion: 0.10
Nodes (34): game_patches_apply_all(), game_patches_get_table(), game_patches_install_helpers(), legacy_apply_all(), main(), apply_relocations(), elf_loader_load(), guest_alloc() (+26 more)

### Community 7 - "Dynarmic CPU Recompiler"
Cohesion: 0.08
Nodes (16): A32::UserCallbacks, dynarmic_call_svc_fn, dynarmic_guest_to_host_fn, CallSVC(), dynarmic_backend_init(), ExceptionRaised(), GunBrosCallbacks, CallSVC (+8 more)

### Community 8 - "HLE Syscall Handlers"
Cohesion: 0.11
Nodes (12): hle_def_t, hle_fn, hle_find_plt_index(), hle_get_handler(), hle_get_plt_name(), hle_init(), hle_register_module(), hle_resolve_import() (+4 more)

### Community 9 - "Network and C Runtime Stubs"
Cohesion: 0.22
Nodes (20): set_guest_errno(), h_abort(), h_android_log_print(), h_cxa_guard_acquire(), h_cxa_guard_release(), h_cxa_pure_virtual(), h_gethostbyname(), h_net_fail() (+12 more)

### Community 10 - "SHA-256 Hashing"
Cohesion: 0.30
Nodes (14): gunbros_sha256_final(), gunbros_sha256_hex(), gunbros_sha256_init(), gunbros_sha256_update(), sha256_ch(), sha256_ep0(), sha256_ep1(), sha256_maj() (+6 more)

### Community 11 - "System Architecture Specification"
Cohesion: 0.17
Nodes (16): AAudio Low-Latency Stream Engine, ANativeWindow and EGL Letterboxing Context, Bridge Core Lifecycle Subsystem, Multithreaded Synchronization Model, Dynarmic Backend Execution Engine, Game-Specific Behavior Hooks, 32-bit Emulated Virtual Memory Layout, JNI Entry Points Subsystem (+8 more)

### Community 12 - "Technical Review and Fixes"
Cohesion: 0.21
Nodes (12): ELF Loader and Dynamic Symbol Linker, HLE Module Registry and SVC Dispatch Table, Author-Pending Configuration Items, Bionic ARM32 104-byte struct stat Layout, Dynamic ELF Import Resolution by Name, Signed Offset Correction in h_fseek, Pure C99 SHA-256 Guest Binary Verification, Centralized Guest Magic Addresses in guest_symbols.h (+4 more)

### Community 13 - "Filesystem and Storage Translation"
Cohesion: 0.18
Nodes (12): Virtual File Handle Table (1..64), Path Mapper and Scoped Storage Translator, Package TOC Prefix Correction (ackTOC to packTOC), Filesystem and Persistence Guide, Internal Game Engine Savegame Reset Hypotheses, WVGA to XGA Texture Resolution Fallback, Scoped Storage Path Normalization and Redirection, Protected Virtual File Descriptor Table (1..64) (+4 more)

### Community 14 - "Testing Framework and Philosophy"
Cohesion: 0.18
Nodes (11): Two-Session Verification Protocol, Automated Testing Framework Guide, Multi-Process Save Persistence Verification, Test Execution and Extension Workflow, Host-Based Isolated Unit Testing Philosophy, Bionic ARM32 Filesystem Persistence, Dynarmic ARM32-to-ARM64 JIT Recompiler, GunBros ARM64 Bridge Overview (+3 more)

### Community 15 - "CMake Build Targets"
Cohesion: 0.28
Nodes (9): gunbros_fs_core Static Library Target, test_file_operations Executable Target, test_guest_memory Executable Target, test_hle_libc Executable Target, test_hle_resolution Executable Target, test_host_io_persistence Executable Target, test_path_mapper Executable Target, test_pcm_ring Executable Target (+1 more)

### Community 16 - "Binary Compatibility Patches"
Cohesion: 0.22
Nodes (9): Declarative Game Patch Registry, Table-Driven Binary Patches Catalog, Patch B (Multi-Touch Dual Stick Control), Patch J (GameSpy Peerchat Network Bypass), Patch E (Weapon Muzzle Flash Matrix Transposition), Patch A (Resource Loader Server Bypass), Patch C (3D Bone Skeletal Mesh Bounds Guard), Patch D (High Refresh Rate Timing Clamping) (+1 more)

### Community 17 - "Cross-Compilation and Packaging"
Cohesion: 0.25
Nodes (8): androidplatformjni Shared Library Target, ADB Deployment with Low Target SDK Bypass, Build Guide and Environment Setup, Environment Configuration via .env, Base Template APK Generator (make_base_apk.sh), NDK Cross-Compilation for ARM64, APK Ingestion, Zipalign, and Apksigner Pipeline, Automated Dependency Setup (setup.sh)

### Community 18 - "Persistence and Golden Save"
Cohesion: 0.25
Nodes (8): golden_save_runner Executable Target, POSIX File Operations with Immediate Flush, Atomic Savegame Update Protocol (temp.dat -> savegame.dat), Aggressive Buffer Flushing (fflush) on I/O, Golden Save Runner (golden_save_runner), Golden Save Tests Documentation, 8-Step Guest Libc I/O Sequence Replication, Device Save Extraction Procedure

### Community 19 - "Diagnostics and Troubleshooting"
Cohesion: 0.25
Nodes (8): Background Stall Watchdog Thread, Automated Log Collection (collect-logs.sh), Common Runtime Issues and Resolutions, Structured Component Logcat Tags, Debugging and Diagnostic Guide, Savegame Inspection and Extraction Procedures, Watchdog Register Dump Analysis, Unification of GunBrosARM64 and GunBrosFS Logcat Tags

## Knowledge Gaps
- **78 isolated node(s):** `build.sh script`, `GUNBROS_EXTERN_C_BEGIN`, `GUNBROS_EXTERN_C_BEGIN`, `GUNBROS_EXTERN_C_BEGIN`, `build.sh script` (+73 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **18 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `guest_to_host()` connect `OpenGL ES 1.1 Emulation` to `Filesystem POSIX Operations`, `HLE ABI and Register Dispatch`, `Audio and Sound Engine`, `Patch Equivalence Verification`, `Network and C Runtime Stubs`?**
  _High betweenness centrality (0.163) - this node is a cross-community bridge._
- **Why does `bridge_on_draw_frame()` connect `Bridge Core Lifecycle` to `HLE Syscall Handlers`, `OpenGL ES 1.1 Emulation`, `Audio and Sound Engine`, `JNI Platform Exports`?**
  _High betweenness centrality (0.076) - this node is a cross-community bridge._
- **Why does `elf_loader_load()` connect `Patch Equivalence Verification` to `HLE Syscall Handlers`, `SHA-256 Hashing`, `Audio and Sound Engine`, `Bridge Core Lifecycle`?**
  _High betweenness centrality (0.073) - this node is a cross-community bridge._
- **Are the 52 inferred relationships involving `guest_to_host()` (e.g. with `get_jni_method_arg()` and `jni_method_open_apk_file()`) actually correct?**
  _`guest_to_host()` has 52 INFERRED edges - model-reasoned connections that need verification._
- **What connects `build.sh script`, `GUNBROS_EXTERN_C_BEGIN`, `GUNBROS_EXTERN_C_BEGIN` to the rest of the system?**
  _79 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Filesystem POSIX Operations` be split into smaller, more focused modules?**
  _Cohesion score 0.06738738738738739 - nodes in this community are weakly interconnected._
- **Should `OpenGL ES 1.1 Emulation` be split into smaller, more focused modules?**
  _Cohesion score 0.0578386605783866 - nodes in this community are weakly interconnected._
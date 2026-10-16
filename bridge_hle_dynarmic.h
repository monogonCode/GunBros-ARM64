/*
 * bridge_hle_patch.h
 *
 * Incluir en arm64_bridge.c justo ANTES de hook_intr_cb. Necesita que ya existan:
 *   LOGI/LOGE, g_uc, g_host_code/heap/stack/stubs, GUEST_HEAP_END, guest_to_host,
 *   guest_alloc/guest_free/guest_cap, normalize_game_path, g_plt_names, find_plt_index.
 *
 * Contenido:
 *   1. DLOG (logs solo en debug)
 *   2. Acceso seguro a memoria del guest (rangos, host_to_guest, errno)
 *   3. Tabla de despacho g_hle[] (sustituye la cadena de strcmp, de forma incremental:
 *      lo que no este en la tabla sigue yendo por la cadena antigua)
 *   4. Handlers nuevos: 64 bits, time, strtok, dir, abort, red desactivada...
 *   5. qsort real (codigo ARM en guest_helpers_bin.h)
 *   6. run_guest / run_slice: ejecucion sin truncar + slices cooperativos
 *   7. Watchdog seguro
 */
#ifndef BRIDGE_HLE_PATCH_H
#define BRIDGE_HLE_PATCH_H

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <time.h>
#include <dirent.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/stat.h>
// unicorn removed
#include "dynarmic_backend.h"
#include "guest_helpers_bin.h"

/* ------------------------------------------------------------------ 1. logs */
#ifndef DLOG
#ifdef BRIDGE_DEBUG
#define DLOG(...) LOGI(__VA_ARGS__)
#else
#define DLOG(...) ((void)0)
#endif
#endif

#define STOP_ADDR          0x8000e000u
#define GUEST_ERRNO_ADDR   0x60007020u
#define GUEST_HELPERS_OFF  0xd000u            /* offset en g_host_stubs -> guest 0x8000d000 */
#define N_PLT              178

_Static_assert(sizeof(g_plt_names) / sizeof(g_plt_names[0]) == N_PLT,
               "g_plt_names no tiene 178 entradas: el resto del bridge asume 178");

/* ------------------------------------------------- 2. memoria del guest segura */
typedef struct { uint32_t lo, hi; } region_t;          /* [lo, hi) */
static const region_t g_regions[] = {
    {0x00000000u, 0x00600000u},          /* codigo/datos del ELF */
    {0x60000000u, GUEST_HEAP_END},       /* heap */
    {0x70000000u, 0x70800000u},          /* pila */
    {0x80000000u, 0x80010000u},          /* stubs */
    {0xffff0000u, 0xffff0000u + 0x10000u}, /* commpage */
};

static bool guest_range_ok(uint32_t a, uint32_t len) {
    if (a == 0) return false;
    uint64_t end = (uint64_t)a + (len ? len : 1);
    for (size_t i = 0; i < sizeof(g_regions) / sizeof(g_regions[0]); i++)
        if (a >= g_regions[i].lo && end <= g_regions[i].hi) return true;
    return false;
}

/* puntero host a [a, a+len) o NULL si cae fuera de memoria conocida */
static void *gptr(uint32_t a, uint32_t len) {
    return guest_range_ok(a, len) ? guest_to_host(a) : NULL;
}

static uint32_t host_to_guest(const void *p) {
    const uint8_t *b = (const uint8_t *)p;
    if (b >= g_host_code  && b < g_host_code  + 0x00600000) return (uint32_t)(b - g_host_code);
    if (b >= g_host_heap  && b < g_host_heap  + 0x10000000) return 0x60000000u + (uint32_t)(b - g_host_heap);
    if (b >= g_host_stack && b < g_host_stack + 0x00800000) return 0x70000000u + (uint32_t)(b - g_host_stack);
    if (b >= g_host_commpage && b < g_host_commpage + 0x00010000) return 0xffff0000u + (uint32_t)(b - g_host_commpage);
    return 0;
}

static void set_guest_errno(int e) {
    int32_t *p = (int32_t *)guest_to_host(GUEST_ERRNO_ADDR);
    if (p) *p = e;   /* los numeros de errno de Linux coinciden entre ARM32 y ARM64 */
}

/* ------------------------------------------------------- 3. tabla de despacho */
typedef struct {
    void *uc;
    uint32_t r0, r1, r2, r3, sp, lr, pc;
    uint32_t out_r1;       /* parte alta de retornos de 64 bits */
    bool     set_r1;
} hle_t;
typedef void (*hle_fn)(hle_t *c);
static hle_fn g_hle[N_PLT];

static uint32_t stack_arg(hle_t *c, int i) {          /* i-esimo argumento en pila (5.o arg = 0) */
    uint32_t v = 0;
    uint32_t *p = (uint32_t*)guest_to_host(c->sp + 4u * (uint32_t)i); if (p) v = *p;
    return v;
}
static void ret64(hle_t *c, uint64_t v) {              /* softfp/EABI: r0 = parte baja, r1 = alta */
    c->r0 = (uint32_t)v; c->out_r1 = (uint32_t)(v >> 32); c->set_r1 = true;
}
static void retdouble(hle_t *c, double d) { uint64_t u; memcpy(&u, &d, 8); ret64(c, u); }

/* ---- memoria ---- */
static void h_malloc(hle_t *c)  { c->r0 = guest_alloc(c->r0); }
static void h_free(hle_t *c)    { guest_free(c->r0); c->r0 = 0; }
static void h_calloc(hle_t *c) {
    uint64_t sz = (uint64_t)c->r0 * c->r1;
    if (sz > 0xffffffffu) { set_guest_errno(ENOMEM); c->r0 = 0; return; }
    c->r0 = guest_alloc((uint32_t)sz);
    void *p = guest_to_host(c->r0);
    if (p) memset(p, 0, (size_t)sz);
}
static void h_realloc(hle_t *c) {
    uint32_t old_ptr = c->r0, sz = c->r1, oldcap = guest_cap(old_ptr);
    if (old_ptr != 0 && sz == 0) { guest_free(old_ptr); c->r0 = 0; return; }
    if (old_ptr != 0 && oldcap >= sz) { c->r0 = old_ptr; return; }
    uint32_t np = guest_alloc(sz);
    if (old_ptr != 0 && np) {
        void *src = guest_to_host(old_ptr), *dst = guest_to_host(np);
        uint32_t n = oldcap ? oldcap : sz;
        if (n > sz) n = sz;
        if (src && dst) memcpy(dst, src, n);
        guest_free(old_ptr);
    }
    c->r0 = np;
}
static void h_memcpy(hle_t *c) {                     /* memcpy y memmove; devuelve dst (r0 intacto) */
    uint32_t n = c->r2;
    if (!n) return;
    void *d = gptr(c->r0, n), *s = gptr(c->r1, n);
    if (d && s) memmove(d, s, n);
    else LOGE("memcpy/memmove fuera de rango dst=0x%x src=0x%x n=%u lr=0x%x", c->r0, c->r1, n, c->lr);
}
static void h_memset(hle_t *c) {
    if (!c->r2) return;
    void *d = gptr(c->r0, c->r2);
    if (d) memset(d, (uint8_t)c->r1, c->r2);
    else LOGE("memset fuera de rango dst=0x%x n=%u lr=0x%x", c->r0, c->r2, c->lr);
}
static void h_memcmp(hle_t *c) {
    void *a = gptr(c->r0, c->r2), *b = gptr(c->r1, c->r2);
    c->r0 = (a && b && c->r2) ? (uint32_t)memcmp(a, b, c->r2) : 0;
}
static void h_strlen(hle_t *c) { const char *s = gptr(c->r0, 1); c->r0 = s ? (uint32_t)strlen(s) : 0; }
static void h_strcmp(hle_t *c) {
    const char *a = gptr(c->r0, 1), *b = gptr(c->r1, 1);
    c->r0 = (a && b) ? (uint32_t)strcmp(a, b) : 0;
}

/* ---- numeros de 64 bits / double ---- */
static void h_atoll(hle_t *c) {
    const char *s = gptr(c->r0, 1);
    ret64(c, s ? (uint64_t)atoll(s) : 0);
}
static void h_strtod(hle_t *c) {                      /* double (r0:r1), y escribe endptr */
    const char *s = gptr(c->r0, 1);
    if (!s) { ret64(c, 0); return; }
    char *end = NULL;
    double d = strtod(s, &end);
    if (c->r1) { uint32_t *pe = gptr(c->r1, 4); if (pe) *pe = c->r0 + (uint32_t)(end - s); }
    retdouble(c, d);
}
static void h_difftime(hle_t *c) {
    retdouble(c, difftime((time_t)(int32_t)c->r0, (time_t)(int32_t)c->r1));
}

/* ---- tiempo: struct tm de bionic ARM32 = 9 int + long gmtoff + char* zone = 44 bytes ---- */
static uint32_t g_tm_static = 0, g_ctime_static = 0;

static void tm_to_guest(const struct tm *t, uint32_t ga, bool full) {
    int32_t *d = gptr(ga, full ? 44 : 36);
    if (!d) return;
    d[0] = t->tm_sec;  d[1] = t->tm_min;  d[2] = t->tm_hour;
    d[3] = t->tm_mday; d[4] = t->tm_mon;  d[5] = t->tm_year;
    d[6] = t->tm_wday; d[7] = t->tm_yday; d[8] = t->tm_isdst;
    if (full) { d[9] = (int32_t)t->tm_gmtoff; d[10] = 0; }
}
static bool guest_to_tm(uint32_t ga, struct tm *t) {
    const int32_t *d = gptr(ga, 36);
    if (!d) return false;
    memset(t, 0, sizeof(*t));
    t->tm_sec = d[0];  t->tm_min = d[1];  t->tm_hour = d[2];
    t->tm_mday = d[3]; t->tm_mon = d[4];  t->tm_year = d[5];
    t->tm_wday = d[6]; t->tm_yday = d[7]; t->tm_isdst = d[8];
    t->tm_zone = "";
    return true;
}
static uint32_t tm_static(void) { if (!g_tm_static) g_tm_static = guest_alloc(64); return g_tm_static; }

static void h_localtime(hle_t *c) {
    const int32_t *tp = gptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; struct tm tv;
    localtime_r(&t, &tv);
    uint32_t g = tm_static(); tm_to_guest(&tv, g, true); c->r0 = g;
}
static void h_gmtime(hle_t *c) {
    const int32_t *tp = gptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; struct tm tv;
    gmtime_r(&t, &tv);
    uint32_t g = tm_static(); tm_to_guest(&tv, g, true); c->r0 = g;
}
static void h_mktime(hle_t *c) {
    struct tm t;
    if (!guest_to_tm(c->r0, &t)) { c->r0 = (uint32_t)-1; return; }
    time_t r = mktime(&t);
    tm_to_guest(&t, c->r0, false);                   /* mktime normaliza los campos */
    c->r0 = (uint32_t)r;
}
static void h_ctime(hle_t *c) {
    const int32_t *tp = gptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; char buf[32];
    if (!ctime_r(&t, buf)) { c->r0 = 0; return; }
    if (!g_ctime_static) g_ctime_static = guest_alloc(32);
    char *dst = gptr(g_ctime_static, 32);
    if (dst) { strncpy(dst, buf, 31); dst[31] = 0; }
    c->r0 = g_ctime_static;
}
static void h_strftime(hle_t *c) {                    /* (s, max, fmt, tm) */
    char *s = gptr(c->r0, c->r1);
    const char *fmt = gptr(c->r2, 1);
    struct tm t;
    if (!s || !fmt || !c->r1 || !guest_to_tm(c->r3, &t)) { c->r0 = 0; return; }
    c->r0 = (uint32_t)strftime(s, c->r1, fmt, &t);
}
static void h_strptime(hle_t *c) {                    /* (s, fmt, tm) */
    const char *s = gptr(c->r0, 1), *fmt = gptr(c->r1, 1);
    struct tm t;
    if (!s || !fmt || !guest_to_tm(c->r2, &t)) { c->r0 = 0; return; }
    char *e = strptime(s, fmt, &t);
    if (!e) { c->r0 = 0; return; }
    tm_to_guest(&t, c->r2, false);
    c->r0 = c->r0 + (uint32_t)(e - s);
}

/* ---- strings con estado ---- */
static void h_strtok(hle_t *c) {
    char *s = c->r0 ? (char *)gptr(c->r0, 1) : NULL;
    const char *d = gptr(c->r1, 1);
    if (!d || (c->r0 && !s)) { c->r0 = 0; return; }
    char *r = strtok(s, d);                          /* el estado interno vive en el host */
    c->r0 = r ? host_to_guest(r) : 0;
}

/* ---- directorios: handles virtuales 1..15 ---- */
#define MAX_DIRS 16
static DIR *g_dirs[MAX_DIRS];
static uint32_t g_dirent_guest = 0;

static void h_opendir(hle_t *c) {
    const char *p = gptr(c->r0, 1);
    char nb[512];
    const char *t = normalize_game_path(p, nb, sizeof(nb));
    DIR *d = t ? opendir(t) : NULL;
    if (!d && p && t != p) d = opendir(p);
    if (!d) { set_guest_errno(errno ? errno : ENOENT); c->r0 = 0; return; }
    for (int i = 1; i < MAX_DIRS; i++)
        if (!g_dirs[i]) { g_dirs[i] = d; c->r0 = (uint32_t)i; return; }
    closedir(d); c->r0 = 0;
}
static void h_readdir(hle_t *c) {
    uint32_t h = c->r0;
    if (h == 0 || h >= MAX_DIRS || !g_dirs[h]) { c->r0 = 0; return; }
    struct dirent *e = readdir(g_dirs[h]);
    if (!e) { c->r0 = 0; return; }
    if (!g_dirent_guest) g_dirent_guest = guest_alloc(288);
    uint8_t *g = gptr(g_dirent_guest, 288);
    if (!g) { c->r0 = 0; return; }
    /* struct dirent de bionic 4.x: u64 d_ino; s64 d_off; u16 d_reclen; u8 d_type; char d_name[256]
       (VERIFICA el offset de d_name=19 desensamblando un readdir del juego) */
    memset(g, 0, 288);
    uint64_t ino = e->d_ino; uint16_t rl = 280;
    memcpy(g, &ino, 8); memcpy(g + 16, &rl, 2); g[18] = e->d_type;
    strncpy((char *)g + 19, e->d_name, 255);
    c->r0 = g_dirent_guest;
}
static void h_closedir(hle_t *c) {
    uint32_t h = c->r0;
    if (h > 0 && h < MAX_DIRS && g_dirs[h]) { closedir(g_dirs[h]); g_dirs[h] = NULL; }
    c->r0 = 0;
}
static void h_mkdir(hle_t *c) {
    const char *p = gptr(c->r0, 1); char nb[512];
    const char *t = normalize_game_path(p, nb, sizeof(nb));
    c->r0 = t ? (uint32_t)mkdir(t, (mode_t)c->r1) : (uint32_t)-1;
}
static void h_rmdir(hle_t *c) {
    const char *p = gptr(c->r0, 1); char nb[512];
    const char *t = normalize_game_path(p, nb, sizeof(nb));
    c->r0 = t ? (uint32_t)rmdir(t) : (uint32_t)-1;
}

/* ---- abort: parar la emulacion y no seguir ejecutando codigo roto ---- */
static volatile int g_guest_dead = 0;
static void h_abort(hle_t *c) {
    LOGE("guest abort()/raise() lr=0x%x r0=0x%x", c->lr, c->r0);
    g_guest_dead = 1;
    dynarmic_backend_halt();
}

/* ---- red desactivada: los servidores de Glu estan muertos ----
   Evita colisiones fd real <-> slot de fichero y connect() bloqueantes en el hilo GL.
   Si algun dia quieres red real, quita estas entradas de g_hle_defs. */
static void h_net_fail(hle_t *c) { set_guest_errno(ENETUNREACH); c->r0 = (uint32_t)-1; }
static void h_ret0(hle_t *c)     { c->r0 = 0; }
static void h_retm1(hle_t *c)    { c->r0 = (uint32_t)-1; }

/* ---- GL caliente (el resto sigue por la cadena antigua) ---- */
static void h_glBindTexture(hle_t *c)       { glBindTexture(c->r0, c->r1); }
static void h_glEnable(hle_t *c)            { glEnable(c->r0); }
static void h_glDisable(hle_t *c)           { glDisable(c->r0); }
static void h_glDrawArrays(hle_t *c)        { glDrawArrays(c->r0, c->r1, c->r2); }
static void h_glDrawElements(hle_t *c)      { glDrawElements(c->r0, c->r1, c->r2, gptr(c->r3, 1)); }
static void h_glVertexPointer(hle_t *c)     { glVertexPointer(c->r0, c->r1, c->r2, gptr(c->r3, 1)); }
static void h_glTexCoordPointer(hle_t *c)   { glTexCoordPointer(c->r0, c->r1, c->r2, gptr(c->r3, 1)); }
static void h_glColorPointer(hle_t *c)      { glColorPointer(c->r0, c->r1, c->r2, gptr(c->r3, 1)); }
static void h_glBlendFunc(hle_t *c)         { glBlendFunc(c->r0, c->r1); }
static void h_glMatrixMode(hle_t *c)        { glMatrixMode(c->r0); }
static void h_glLoadIdentity(hle_t *c)      { (void)c; glLoadIdentity(); }
static void h_glEnableClientState(hle_t *c) { glEnableClientState(c->r0); }
static void h_glDisableClientState(hle_t *c){ glDisableClientState(c->r0); }
static void h_glLoadMatrixf(hle_t *c)       { void *p = gptr(c->r0, 64); if (p) glLoadMatrixf((const GLfloat *)p); }
static void h_glColor4f(hle_t *c) {
    float r, g, b, a;
    memcpy(&r, &c->r0, 4); memcpy(&g, &c->r1, 4); memcpy(&b, &c->r2, 4); memcpy(&a, &c->r3, 4);
    glColor4f(r, g, b, a);
}

static const struct { const char *name; hle_fn fn; } g_hle_defs[] = {
    {"malloc", h_malloc}, {"free", h_free}, {"calloc", h_calloc}, {"realloc", h_realloc},
    {"memcpy", h_memcpy}, {"memmove", h_memcpy}, {"memset", h_memset}, {"memcmp", h_memcmp},
    {"strlen", h_strlen}, {"strcmp", h_strcmp},
    {"atoll", h_atoll}, {"strtod", h_strtod}, {"difftime", h_difftime},
    {"localtime", h_localtime}, {"gmtime", h_gmtime}, {"mktime", h_mktime}, {"ctime", h_ctime},
    {"strftime", h_strftime}, {"strptime", h_strptime}, {"strtok", h_strtok},
    {"opendir", h_opendir}, {"readdir", h_readdir}, {"closedir", h_closedir},
    {"mkdir", h_mkdir}, {"rmdir", h_rmdir},
    {"abort", h_abort}, {"raise", h_abort},
    {"usleep", h_ret0}, {"puts", h_ret0}, {"fprintf", h_ret0}, {"fdopen", h_ret0},
    {"dup", h_retm1}, {"select", h_ret0}, {"ioctl", h_ret0}, {"mkstemp", h_retm1},
    {"glBindTexture", h_glBindTexture}, {"glEnable", h_glEnable}, {"glDisable", h_glDisable},
    {"glDrawArrays", h_glDrawArrays}, {"glDrawElements", h_glDrawElements},
    {"glVertexPointer", h_glVertexPointer}, {"glTexCoordPointer", h_glTexCoordPointer},
    {"glColorPointer", h_glColorPointer}, {"glBlendFunc", h_glBlendFunc},
    {"glMatrixMode", h_glMatrixMode}, {"glLoadIdentity", h_glLoadIdentity},
    {"glEnableClientState", h_glEnableClientState}, {"glDisableClientState", h_glDisableClientState},
    {"glLoadMatrixf", h_glLoadMatrixf}, {"glColor4f", h_glColor4f},
};

/* Llamar UNA vez en load_elf_from_buffer, despues de rellenar los 178 stubs con "svc; bx lr" */
static void hle_init(void) {
    for (size_t i = 0; i < sizeof(g_hle_defs) / sizeof(g_hle_defs[0]); i++) {
        int idx = find_plt_index(g_hle_defs[i].name);
        if (idx >= 0) g_hle[idx] = g_hle_defs[i].fn;
        else LOGE("hle_init: '%s' no esta en g_plt_names", g_hle_defs[i].name);
    }
}

/* ----------------------------------------------- 5. codigo guest (qsort en ARM) */
/* Sustituye el stub "svc; bx lr" del slot por "ldr pc,[pc,#-4]; .word destino": la llamada
   salta a codigo ARM real dentro de Unicorn, que puede llamar al comparador con blx sin
   re-entrar en uc_emu_start. Llamar DESPUES de rellenar los stubs. */
static void install_guest_helpers(void) {
    if (guest_helpers_bin_len > 0x1000) { LOGE("guest_helpers demasiado grande (%u)", guest_helpers_bin_len); return; }
    memcpy(g_host_stubs + GUEST_HELPERS_OFF, guest_helpers_bin, guest_helpers_bin_len);
    int idx = find_plt_index("qsort");
    if (idx < 0) { LOGE("install_guest_helpers: qsort no esta en g_plt_names"); return; }
    uint32_t slot[2] = { 0xe51ff004u, 0x80000000u + GUEST_HELPERS_OFF };  /* guest_qsort en offset 0 */
    memcpy(g_host_stubs + idx * 8, slot, 8);
}

/* ------------------------------------------------- 6. ejecucion sin truncar */
typedef enum { RUN_OK = 0, RUN_PREEMPTED, RUN_ERROR, RUN_DEAD } run_result_t;

static volatile uint64_t g_call_start_ns = 0;     /* 0 = ninguna llamada en curso (lo lee el watchdog) */
static bool     g_pending = false;                /* hay una llamada preemptada pendiente de reanudar */
static uint32_t g_resume_pc = 0;

static uint64_t now_ns(void) {
    struct timespec ts; clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000ull + (uint64_t)ts.tv_nsec;
}

static run_result_t run_guest(uint32_t entry, const char *tag) {
    if (g_guest_dead || !dynarmic_backend_is_active()) return RUN_DEAD;
    g_call_start_ns = now_ns();
    dynarmic_backend_run(entry);
    g_call_start_ns = 0;
    if (g_guest_dead) return RUN_DEAD;
    return RUN_OK;
}
static void drain_pending(void) {}

static void *watchdog_thread(void *arg) {
    (void)arg;
    for (;;) {
        sleep(2);
        uint64_t st = g_call_start_ns;
        if (st && now_ns() - st > 20ull * 1000000000ull) {
            LOGE("WATCHDOG: llamada al guest sin terminar tras 20 s -> halt");
            dynarmic_backend_halt();
        }
    }
    return NULL;
}
static void start_watchdog_once(void) {
    static int started = 0;
    if (started) return;
    started = 1;
    pthread_t t; pthread_create(&t, NULL, watchdog_thread, NULL);
}

#endif /* BRIDGE_HLE_PATCH_H */

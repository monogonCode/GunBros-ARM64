#include "gunbros/emulator/guest_memory.h"
#include <sys/mman.h>
#include <string.h>

static uint8_t *s_host_code = NULL;
static uint8_t *s_host_heap = NULL;
static uint8_t *s_host_stack = NULL;
static uint8_t *s_host_stubs = NULL;
static uint8_t *s_host_commpage = NULL;

static uint32_t s_heap_top = 0x60100000;
static uint32_t s_free_bins[256];

typedef struct { uint32_t lo, hi; } region_t;
static const region_t s_regions[] = {
    {GUEST_CODE_BASE, GUEST_CODE_BASE + GUEST_CODE_SIZE},
    {GUEST_HEAP_BASE, GUEST_HEAP_END},
    {GUEST_STACK_BASE, GUEST_STACK_BASE + GUEST_STACK_SIZE},
    {GUEST_STUBS_BASE, GUEST_STUBS_BASE + GUEST_STUBS_SIZE},
    {GUEST_COMMPAGE_BASE, GUEST_COMMPAGE_BASE + GUEST_COMMPAGE_SIZE},
};

static inline uint32_t heap_round(uint32_t sz) {
    if (sz == 0) sz = 1;
    if (sz <= 1024) return (sz + 15u) & ~15u;
    if (sz > 0x40000000u) return 0;
    int p = 31 - __builtin_clz(sz - 1u);
    if (p < 2 || p >= 31) return 0;
    uint32_t step = 1u << (p - 2);
    uint64_t rounded = (((uint64_t)sz + step - 1u) / step) * step;
    return (rounded > UINT32_MAX) ? 0 : (uint32_t)rounded;
}

static inline int heap_bin(uint32_t cap) {
    if (cap == 0) return -1;
    if (cap <= 1024) return cap / 16;
    int p = 31 - __builtin_clz(cap - 1);
    uint32_t step = 1u << (p - 2);
    int sub = (int)((cap - 1 - (1u << p)) / step);
    return 65 + (p - 10) * 4 + sub;
}

bool guest_memory_init(void) {
    if (s_host_code != NULL) return true;

    s_host_code = (uint8_t*)mmap(NULL, GUEST_CODE_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    s_host_heap = (uint8_t*)mmap(NULL, GUEST_HEAP_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
    s_host_stack = (uint8_t*)mmap(NULL, GUEST_STACK_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    s_host_stubs = (uint8_t*)mmap(NULL, GUEST_STUBS_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    s_host_commpage = (uint8_t*)mmap(NULL, GUEST_COMMPAGE_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

    if (s_host_code == MAP_FAILED || s_host_heap == MAP_FAILED ||
        s_host_stack == MAP_FAILED || s_host_stubs == MAP_FAILED ||
        s_host_commpage == MAP_FAILED) {
        LOGE("Failed to allocate guest memory regions: errno=%d", errno);
        guest_memory_release();
        return false;
    }

    s_heap_top = 0x60100000;
    memset(s_free_bins, 0, sizeof(s_free_bins));
    return true;
}

void guest_memory_setup_commpage(void) {
    if (!s_host_commpage) return;

    // 0xffff0fa0: __kuser_memory_barrier (dmb; bx lr)
    uint32_t mb_code[2] = { 0xe12fff1e, 0xe12fff1e };
    memcpy(s_host_commpage + 0x0fa0, mb_code, sizeof(mb_code));

    // 0xffff0fc0: __kuser_cmpxchg (r0=old, r1=new, r2=ptr)
    uint32_t cmpxchg_code[5] = { 0xe5923000, 0xe0533000, 0x05821000, 0xe1a00003, 0xe12fff1e };
    memcpy(s_host_commpage + 0x0fc0, cmpxchg_code, sizeof(cmpxchg_code));

    // 0xffff0fe0: __kuser_get_tls (returns pointer in r0)
    uint32_t tls_code[3] = { 0xe59f0000, 0xe12fff1e, 0x60007000 };
    memcpy(s_host_commpage + 0x0fe0, tls_code, sizeof(tls_code));

    // 0xffff0ffc: __kuser_helper_version
    *(uint32_t*)(s_host_commpage + 0x0ffc) = 5;

    // Initialize Bionic libc _ctype_, _tolower_tab_, _toupper_tab_ in commpage
    uint8_t *ctype_buf = s_host_commpage + 0x1000;
    int16_t *tolower_buf = (int16_t*)(s_host_commpage + 0x1200);
    int16_t *toupper_buf = (int16_t*)(s_host_commpage + 0x1500);

    ctype_buf[0] = 0;
    tolower_buf[0] = -1;
    toupper_buf[0] = -1;
    for (int i = 0; i < 256; i++) {
        uint8_t flags = 0;
        if (i >= 'A' && i <= 'Z') flags |= 0x01; // _U
        if (i >= 'a' && i <= 'z') flags |= 0x02; // _L
        if (i >= '0' && i <= '9') flags |= 0x04; // _N
        if (i == ' ' || (i >= 0x09 && i <= 0x0d)) flags |= 0x08; // _S
        if ((i >= 0x21 && i <= 0x2f) || (i >= 0x3a && i <= 0x40) ||
            (i >= 0x5b && i <= 0x60) || (i >= 0x7b && i <= 0x7e)) flags |= 0x10; // _P
        if (i < 0x20 || i == 0x7f) flags |= 0x20; // _C
        if ((i >= '0' && i <= '9') || (i >= 'a' && i <= 'f') || (i >= 'A' && i <= 'F')) flags |= 0x40; // _X
        if (i == ' ' || i == '\t') flags |= 0x80; // _B
        ctype_buf[i + 1] = flags;

        tolower_buf[i + 1] = (i >= 'A' && i <= 'Z') ? (i + 32) : i;
        toupper_buf[i + 1] = (i >= 'a' && i <= 'z') ? (i - 32) : i;
    }

    // Pointer variables in commpage:
    *(uint32_t*)(s_host_commpage + 0x1800) = 0xffff1000;
    *(uint32_t*)(s_host_commpage + 0x1804) = 0xffff1200;
    *(uint32_t*)(s_host_commpage + 0x1808) = 0xffff1500;
}

void guest_memory_release(void) {
    if (s_host_code && s_host_code != MAP_FAILED) munmap(s_host_code, GUEST_CODE_SIZE);
    if (s_host_heap && s_host_heap != MAP_FAILED) munmap(s_host_heap, GUEST_HEAP_SIZE);
    if (s_host_stack && s_host_stack != MAP_FAILED) munmap(s_host_stack, GUEST_STACK_SIZE);
    if (s_host_stubs && s_host_stubs != MAP_FAILED) munmap(s_host_stubs, GUEST_STUBS_SIZE);
    if (s_host_commpage && s_host_commpage != MAP_FAILED) munmap(s_host_commpage, GUEST_COMMPAGE_SIZE);
    s_host_code = s_host_heap = s_host_stack = s_host_stubs = s_host_commpage = NULL;
}

uint8_t* guest_memory_get_code(void) { return s_host_code; }
uint8_t* guest_memory_get_heap(void) { return s_host_heap; }
uint8_t* guest_memory_get_stack(void) { return s_host_stack; }
uint8_t* guest_memory_get_stubs(void) { return s_host_stubs; }
uint8_t* guest_memory_get_commpage(void) { return s_host_commpage; }

void* guest_to_host(uint32_t addr) {
    if (addr == 0) return NULL;
    if (addr < GUEST_CODE_SIZE) return (void*)(s_host_code + addr);
    if (addr >= GUEST_HEAP_BASE && addr < GUEST_HEAP_END) return (void*)(s_host_heap + (addr - GUEST_HEAP_BASE));
    if (addr >= GUEST_STACK_BASE && addr < GUEST_STACK_BASE + GUEST_STACK_SIZE) return (void*)(s_host_stack + (addr - GUEST_STACK_BASE));
    if (addr >= GUEST_STUBS_BASE && addr < GUEST_STUBS_BASE + GUEST_STUBS_SIZE) return (void*)(s_host_stubs + (addr - GUEST_STUBS_BASE));
    if (addr >= GUEST_COMMPAGE_BASE) return (void*)(s_host_commpage + (addr - GUEST_COMMPAGE_BASE));
    return NULL;
}

uint32_t host_to_guest(const void *p) {
    const uint8_t *b = (const uint8_t *)p;
    if (b >= s_host_code  && b < s_host_code  + GUEST_CODE_SIZE) return (uint32_t)(b - s_host_code);
    if (b >= s_host_heap  && b < s_host_heap  + GUEST_HEAP_SIZE) return GUEST_HEAP_BASE + (uint32_t)(b - s_host_heap);
    if (b >= s_host_stack && b < s_host_stack + GUEST_STACK_SIZE) return GUEST_STACK_BASE + (uint32_t)(b - s_host_stack);
    if (b >= s_host_commpage && b < s_host_commpage + GUEST_COMMPAGE_SIZE) return GUEST_COMMPAGE_BASE + (uint32_t)(b - s_host_commpage);
    return 0;
}

bool guest_range_ok(uint32_t addr, uint32_t len) {
    if (addr == 0) return false;
    uint64_t end = (uint64_t)addr + (len ? len : 1);
    for (size_t i = 0; i < sizeof(s_regions) / sizeof(s_regions[0]); i++) {
        if (addr >= s_regions[i].lo && end <= s_regions[i].hi) return true;
    }
    return false;
}

void* guest_ptr(uint32_t addr, uint32_t len) {
    return guest_range_ok(addr, len) ? guest_to_host(addr) : NULL;
}

void guest_mem_read(uint32_t addr, void *dst, size_t sz) {
    void *p = guest_to_host(addr);
    if (p) memcpy(dst, p, sz);
    else memset(dst, 0, sz);
}

void guest_mem_write(uint32_t addr, const void *src, size_t sz) {
    void *p = guest_to_host(addr);
    if (p) memcpy(p, src, sz);
}

void set_guest_errno(int err) {
    int32_t *p = (int32_t *)guest_to_host(GUEST_ERRNO_ADDR);
    if (p) *p = err;
}

uint32_t guest_alloc(uint32_t sz) {
    uint32_t cap = heap_round(sz);
    int b = heap_bin(cap);
    if (cap == 0 || b < 0 || b >= (int)(sizeof(s_free_bins) / sizeof(s_free_bins[0]))) return 0;
    uint32_t blk = s_free_bins[b];
    if (blk) {
        s_free_bins[b] = *(uint32_t*)guest_to_host(blk - 12);
        memset(guest_to_host(blk), 0, cap);
        return blk;
    }
    uint32_t hdr = s_heap_top;
    if ((uint64_t)hdr + 16 + cap > GUEST_HEAP_END) return 0;
    s_heap_top = hdr + 16 + cap;
    *(uint32_t*)guest_to_host(hdr) = cap;
    memset(guest_to_host(hdr + 16), 0, cap);
    return hdr + 16;
}

void guest_free(uint32_t ptr) {
    if (ptr < 0x60100010u || ptr >= GUEST_HEAP_END || (ptr & 15)) return;
    uint32_t cap = *(uint32_t*)guest_to_host(ptr - 16);
    if (cap == 0 || cap != heap_round(cap)) return;
    int b = heap_bin(cap);
    if (b < 0 || b >= (int)(sizeof(s_free_bins) / sizeof(s_free_bins[0]))) return;
    *(uint32_t*)guest_to_host(ptr - 12) = s_free_bins[b];
    s_free_bins[b] = ptr;
}

uint32_t guest_cap(uint32_t ptr) {
    if (ptr < 0x60100010u || ptr >= GUEST_HEAP_END || (ptr & 15)) return 0;
    uint32_t cap = *(uint32_t*)guest_to_host(ptr - 16);
    if (cap == 0 || cap > GUEST_HEAP_END - ptr || heap_round(cap) != cap) return 0;
    return cap;
}

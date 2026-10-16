/*
 * guest_helpers.c -- codigo ARM32 que corre DENTRO de Unicorn (no en el host).
 *
 * Reglas: sin libc, sin globales, sin .rodata, y guest_qsort DEBE ser la unica
 * funcion que no se inlinea (queda en el offset 0 del .text). build_guest_helpers.sh
 * lo compila y genera guest_helpers_bin.h.
 *
 * qsort via heapsort: sin memoria extra, O(n log n), no estable (el qsort de
 * bionic tampoco lo era).
 */
typedef int (*cmp_fn)(const void *, const void *);

static inline __attribute__((always_inline))
void gswap(unsigned char *a, unsigned char *b, unsigned n) {
    while (n--) { unsigned char t = *a; *a++ = *b; *b++ = t; }
}

static inline __attribute__((always_inline))
void gsift(unsigned char *b, unsigned size, unsigned root, unsigned end, cmp_fn cmp) {
    for (;;) {
        unsigned child = 2 * root + 1;
        if (child >= end) return;
        if (child + 1 < end && cmp(b + child * size, b + (child + 1) * size) < 0) child++;
        if (cmp(b + root * size, b + child * size) >= 0) return;
        gswap(b + root * size, b + child * size, size);
        root = child;
    }
}

__attribute__((noinline, used))
void guest_qsort(void *base, unsigned n, unsigned size, cmp_fn cmp) {
    unsigned char *b = (unsigned char *)base;
    if (n < 2 || size == 0) return;
    for (int s = (int)(n - 2) / 2; s >= 0; s--) gsift(b, size, (unsigned)s, n, cmp);
    for (unsigned end = n - 1; end > 0; end--) {
        gswap(b, b + end * size, size);
        gsift(b, size, 0, end, cmp);
    }
}

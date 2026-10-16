#include "gunbros/platform/pcm_ring.h"
#include <string.h>

#define LOAD_ACQ(p)      __atomic_load_n((p), __ATOMIC_ACQUIRE)
#define LOAD_RLX(p)      __atomic_load_n((p), __ATOMIC_RELAXED)
#define STORE_REL(p, v)  __atomic_store_n((p), (v), __ATOMIC_RELEASE)

void pcm_ring_init(pcm_ring_t *r) {
    if (!r) return;
    memset(r, 0, sizeof(*r));
}

size_t pcm_ring_available(const pcm_ring_t *r) {
    if (!r) return 0;
    return LOAD_ACQ(&r->head) - LOAD_ACQ(&r->tail);
}

size_t pcm_ring_space(const pcm_ring_t *r) {
    return PCM_RING_CAP - pcm_ring_available(r);
}

size_t pcm_ring_write(pcm_ring_t *r, const uint8_t *src, size_t len) {
    if (!r || !src || len == 0) return 0;
    size_t head = LOAD_RLX(&r->head);
    size_t tail = LOAD_ACQ(&r->tail);
    if (PCM_RING_CAP - (head - tail) < len) return 0;
    size_t off = head & (PCM_RING_CAP - 1u);
    size_t first = PCM_RING_CAP - off;
    if (first > len) first = len;
    memcpy(r->buf + off, src, first);
    if (len > first) memcpy(r->buf, src + first, len - first);
    STORE_REL(&r->head, head + len);
    return len;
}

size_t pcm_ring_read(pcm_ring_t *r, uint8_t *dst, size_t len) {
    if (!r || !dst || len == 0) return 0;
    size_t tail = LOAD_RLX(&r->tail);
    size_t head = LOAD_ACQ(&r->head);
    size_t avail = head - tail;
    if (len > avail) len = avail;
    if (len == 0) return 0;
    size_t off = tail & (PCM_RING_CAP - 1u);
    size_t first = PCM_RING_CAP - off;
    if (first > len) first = len;
    memcpy(dst, r->buf + off, first);
    if (len > first) memcpy(dst + first, r->buf, len - first);
    STORE_REL(&r->tail, tail + len);
    return len;
}

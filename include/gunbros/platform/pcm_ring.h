#ifndef GUNBROS_PCM_RING_H
#define GUNBROS_PCM_RING_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

/* SPSC lock-free byte ring. Capacity must be a power of two.
 * 65536 B >= 200 ms of 44100 Hz / 16-bit / stereo (35280 B). */
#define PCM_RING_CAP 65536u

typedef struct {
    uint8_t buf[PCM_RING_CAP];
    size_t head;                 /* written only by producer */
    size_t tail;                 /* written only by consumer */
    uint32_t underruns;          /* consumer-side counter */
} pcm_ring_t;

void   pcm_ring_init(pcm_ring_t *r);
size_t pcm_ring_available(const pcm_ring_t *r);                         /* bytes readable */
size_t pcm_ring_space(const pcm_ring_t *r);                             /* bytes writable */
size_t pcm_ring_write(pcm_ring_t *r, const uint8_t *src, size_t len);   /* all-or-nothing */
size_t pcm_ring_read(pcm_ring_t *r, uint8_t *dst, size_t len);          /* up to len */

GUNBROS_EXTERN_C_END

#endif // GUNBROS_PCM_RING_H

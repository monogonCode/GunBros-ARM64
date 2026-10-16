#define _GNU_SOURCE
#include "hle_internal.h"
#include "gunbros/hle/hle_libc.h"
#include <time.h>
#include <sys/time.h>
#include <math.h>
#include <stdlib.h>

/* ---------------- Time Operations ---------------- */
void h_clock(hle_t *c) { c->r0 = (uint32_t)clock(); }

void h_time(hle_t *c) {
    time_t t = time(NULL);
    if (c->r0) {
        uint32_t *tp = (uint32_t*)guest_ptr(c->r0, 4);
        if (tp) *tp = (uint32_t)t;
    }
    c->r0 = (uint32_t)t;
}

void h_gettimeofday(hle_t *c) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    if (c->r0) {
        uint32_t *gtv = (uint32_t*)guest_ptr(c->r0, 8);
        if (gtv) {
            gtv[0] = (uint32_t)tv.tv_sec;
            gtv[1] = (uint32_t)tv.tv_usec;
        }
    }
    c->r0 = 0;
}

void h_clock_gettime(hle_t *c) {
    struct timespec ts;
    int res = clock_gettime((clockid_t)c->r0, &ts);
    if (c->r1 && res == 0) {
        uint32_t *gts = (uint32_t*)guest_ptr(c->r1, 8);
        if (gts) {
            gts[0] = (uint32_t)ts.tv_sec;
            gts[1] = (uint32_t)ts.tv_nsec;
        }
    }
    c->r0 = (uint32_t)res;
}

void h_difftime(hle_t *c) {
    hle_retdouble(c, difftime((time_t)(int32_t)c->r0, (time_t)(int32_t)c->r1));
}

static uint32_t s_tm_static = 0, s_ctime_static = 0;

static void tm_to_guest(const struct tm *t, uint32_t ga, bool full) {
    int32_t *d = guest_ptr(ga, full ? 44 : 36);
    if (!d) return;
    d[0] = t->tm_sec;  d[1] = t->tm_min;  d[2] = t->tm_hour;
    d[3] = t->tm_mday; d[4] = t->tm_mon;  d[5] = t->tm_year;
    d[6] = t->tm_wday; d[7] = t->tm_yday; d[8] = t->tm_isdst;
    if (full) { d[9] = (int32_t)t->tm_gmtoff; d[10] = 0; }
}

static bool guest_to_tm(uint32_t ga, struct tm *t) {
    const int32_t *d = guest_ptr(ga, 36);
    if (!d) return false;
    memset(t, 0, sizeof(*t));
    t->tm_sec = d[0];  t->tm_min = d[1];  t->tm_hour = d[2];
    t->tm_mday = d[3]; t->tm_mon = d[4];  t->tm_year = d[5];
    t->tm_wday = d[6]; t->tm_yday = d[7]; t->tm_isdst = d[8];
    t->tm_zone = "";
    return true;
}

static uint32_t tm_static(void) {
    if (!s_tm_static) s_tm_static = guest_alloc(64);
    return s_tm_static;
}

void h_localtime(hle_t *c) {
    const int32_t *tp = guest_ptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; struct tm tv;
    localtime_r(&t, &tv);
    uint32_t g = tm_static(); tm_to_guest(&tv, g, true); c->r0 = g;
}

void h_gmtime(hle_t *c) {
    const int32_t *tp = guest_ptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; struct tm tv;
    gmtime_r(&t, &tv);
    uint32_t g = tm_static(); tm_to_guest(&tv, g, true); c->r0 = g;
}

void h_mktime(hle_t *c) {
    struct tm t;
    if (!guest_to_tm(c->r0, &t)) { c->r0 = (uint32_t)-1; return; }
    time_t r = mktime(&t);
    tm_to_guest(&t, c->r0, false);
    c->r0 = (uint32_t)r;
}

void h_ctime(hle_t *c) {
    const int32_t *tp = guest_ptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; char buf[32];
    if (!ctime_r(&t, buf)) { c->r0 = 0; return; }
    if (!s_ctime_static) s_ctime_static = guest_alloc(32);
    char *dst = guest_ptr(s_ctime_static, 32);
    if (dst) { strncpy(dst, buf, 31); dst[31] = 0; }
    c->r0 = s_ctime_static;
}

static void h_strftime(hle_t *c) {
    char *s = guest_ptr(c->r0, c->r1);
    const char *fmt = guest_ptr(c->r2, 1);
    struct tm t;
    if (!s || !fmt || !c->r1 || !guest_to_tm(c->r3, &t)) { c->r0 = 0; return; }
    c->r0 = (uint32_t)strftime(s, c->r1, fmt, &t);
}

static void h_strptime(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1), *fmt = guest_ptr(c->r1, 1);
    struct tm t;
    if (!s || !fmt || !guest_to_tm(c->r2, &t)) { c->r0 = 0; return; }
    char *e = strptime(s, fmt, &t);
    if (!e) { c->r0 = 0; return; }
    tm_to_guest(&t, c->r2, false);
    c->r0 = c->r0 + (uint32_t)(e - s);
}

/* ---------------- Math Operations ---------------- */
static void h_sinf(hle_t *c)   { hle_float_ret(c, sinf(hle_float_arg0(c))); }
static void h_cosf(hle_t *c)   { hle_float_ret(c, cosf(hle_float_arg0(c))); }
static void h_sqrtf(hle_t *c)  { hle_float_ret(c, sqrtf(hle_float_arg0(c))); }
static void h_atan2f(hle_t *c) { hle_float_ret(c, atan2f(hle_float_arg0(c), hle_float_arg1(c))); }
static void h_atanf(hle_t *c)  { hle_float_ret(c, atanf(hle_float_arg0(c))); }
static void h_asinf(hle_t *c)  { hle_float_ret(c, asinf(hle_float_arg0(c))); }
static void h_acosf(hle_t *c)  { hle_float_ret(c, acosf(hle_float_arg0(c))); }
static void h_floorf(hle_t *c) { hle_float_ret(c, floorf(hle_float_arg0(c))); }
static void h_ceilf(hle_t *c)  { hle_float_ret(c, ceilf(hle_float_arg0(c))); }
static void h_modff(hle_t *c) {
    float i_part = 0;
    float res = modff(hle_float_arg0(c), &i_part);
    if (c->r1) {
        float *pi = (float*)guest_to_host(c->r1);
        if (pi) *pi = i_part;
    }
    hle_float_ret(c, res);
}

static void h_srand48(hle_t *c) { srand48(c->r0); c->r0 = 0; }
static void h_lrand48(hle_t *c) { c->r0 = (uint32_t)lrand48(); }

const hle_def_t g_hle_libc_time_defs[] = {
    {"clock", h_clock}, {"time", h_time}, {"gettimeofday", h_gettimeofday}, {"clock_gettime", h_clock_gettime},
    {"difftime", h_difftime}, {"localtime", h_localtime}, {"gmtime", h_gmtime}, {"mktime", h_mktime},
    {"ctime", h_ctime}, {"strftime", h_strftime}, {"strptime", h_strptime},
    {"sinf", h_sinf}, {"cosf", h_cosf}, {"sqrtf", h_sqrtf}, {"atan2f", h_atan2f},
    {"atanf", h_atanf}, {"asinf", h_asinf}, {"acosf", h_acosf}, {"floorf", h_floorf},
    {"ceilf", h_ceilf}, {"modff", h_modff}, {"srand48", h_srand48}, {"lrand48", h_lrand48},
};

const size_t g_hle_libc_time_defs_count = sizeof(g_hle_libc_time_defs) / sizeof(g_hle_libc_time_defs[0]);

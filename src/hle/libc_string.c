#include "hle_internal.h"
#include "gunbros/hle/hle_libc.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>

/* ---------------- Memory HLE ---------------- */
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
static void h_memcpy(hle_t *c) {
    uint32_t n = c->r2;
    if (!n) return;
    void *d = guest_ptr(c->r0, n), *s = guest_ptr(c->r1, n);
    if (d && s) memmove(d, s, n);
    else LOGE("memcpy/memmove out of bounds dst=0x%x src=0x%x n=%u lr=0x%x", c->r0, c->r1, n, c->lr);
}
static void h_memset(hle_t *c) {
    if (!c->r2) return;
    void *d = guest_ptr(c->r0, c->r2);
    if (d) memset(d, (uint8_t)c->r1, c->r2);
    else LOGE("memset out of bounds dst=0x%x n=%u lr=0x%x", c->r0, c->r2, c->lr);
}
static void h_memcmp(hle_t *c) {
    void *a = guest_ptr(c->r0, c->r2), *b = guest_ptr(c->r1, c->r2);
    c->r0 = (a && b && c->r2) ? (uint32_t)memcmp(a, b, c->r2) : 0;
}
static void h_memchr(hle_t *c) {
    void *src = guest_ptr(c->r0, c->r2);
    void *p = (src && c->r2 > 0) ? memchr(src, c->r1, c->r2) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)((uint8_t*)p - (uint8_t*)src)) : 0;
}

/* ---------------- String Operations ---------------- */
static void h_strlen(hle_t *c) { const char *s = guest_ptr(c->r0, 1); c->r0 = s ? (uint32_t)strlen(s) : 0; }
static void h_strcmp(hle_t *c) {
    const char *a = guest_ptr(c->r0, 1), *b = guest_ptr(c->r1, 1);
    c->r0 = (a && b) ? (uint32_t)strcmp(a, b) : 0;
}
static void h_strncmp(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strncmp(s1, s2, c->r2) : 0;
}
static void h_strcasecmp(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strcasecmp(s1, s2) : 0;
}
static void h_strncasecmp(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strncasecmp(s1, s2, c->r2) : 0;
}
static void h_strcpy(hle_t *c) {
    char *dst = guest_ptr(c->r0, 1);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strcpy(dst, src);
}
static void h_strncpy(hle_t *c) {
    char *dst = guest_ptr(c->r0, c->r2);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strncpy(dst, src, c->r2);
}
static void h_strcat(hle_t *c) {
    char *dst = guest_ptr(c->r0, 1);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strcat(dst, src);
}
static void h_strncat(hle_t *c) {
    char *dst = guest_ptr(c->r0, 1);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strncat(dst, src, c->r2);
}
static void h_strchr(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    char *p = s ? strchr(s, c->r1) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)(p - s)) : 0;
}
static void h_strrchr(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    char *p = s ? strrchr(s, c->r1) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)(p - s)) : 0;
}
static void h_strstr(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    char *p = (s1 && s2) ? strstr(s1, s2) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)(p - s1)) : 0;
}
static void h_strdup(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    if (s) {
        uint32_t len = (uint32_t)strlen(s) + 1;
        c->r0 = guest_alloc(len);
        char *dst = (char*)guest_to_host(c->r0);
        if (dst) memcpy(dst, s, len);
    } else {
        c->r0 = 0;
    }
}
static void h_strspn(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strspn(s1, s2) : 0;
}
static void h_strcspn(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strcspn(s1, s2) : 0;
}
static void h_wcslen(hle_t *c) {
    const uint16_t *ws = (const uint16_t*)guest_ptr(c->r0, 2);
    uint32_t cnt = 0;
    if (ws) { while (*ws++) cnt++; }
    c->r0 = cnt;
}

/* ---------------- String Formatting & Conversion ---------------- */

static uint32_t get_guest_vararg(uint32_t *reg_args, int reg_count, uint32_t sp, int *arg_idx) {
    int idx = *arg_idx;
    (*arg_idx)++;
    if (idx < reg_count && reg_args != NULL) {
        return reg_args[idx];
    } else {
        uint32_t val = 0;
        int stack_offset = (reg_args != NULL) ? (idx - reg_count) * 4 : idx * 4;
        guest_mem_read(sp + stack_offset, &val, 4);
        return val;
    }
}

int safe_guest_snprintf(char *dst, size_t max_len, const char *fmt, uint32_t *reg_args, int reg_count, uint32_t sp) {
    if (!dst || max_len == 0) return 0;
    if (!fmt) { dst[0] = '\0'; return 0; }

    char temp[1024];
    size_t out_len = 0;
    int arg_idx = 0;
    const char *p = fmt;

    while (*p != '\0' && out_len + 1 < sizeof(temp)) {
        if (*p != '%') {
            temp[out_len++] = *p++;
            continue;
        }

        p++; // skip '%'
        if (*p == '%') {
            temp[out_len++] = '%';
            p++;
            continue;
        }

        char spec[32];
        int s_idx = 0;
        spec[s_idx++] = '%';
        while (*p && strchr("0123456789.-+ #lhjzt", *p) && s_idx < 30) {
            spec[s_idx++] = *p++;
        }
        char type = *p ? *p++ : '\0';
        spec[s_idx++] = type;
        spec[s_idx] = '\0';

        char formatted[256];
        formatted[0] = '\0';

        if (type == 's') {
            uint32_t guest_ptr_val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            const char *str = (const char*)guest_to_host(guest_ptr_val);
            if (!str) str = "";
            snprintf(formatted, sizeof(formatted), spec, str);
        } else if (type == 'd' || type == 'i') {
            uint32_t val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, (int32_t)val);
        } else if (type == 'u' || type == 'x' || type == 'X' || type == 'p') {
            uint32_t val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, val);
        } else if (type == 'c') {
            uint32_t val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, (char)val);
        } else if (type == 'f' || type == 'g' || type == 'e') {
            if (arg_idx & 1) arg_idx++;
            uint32_t lo = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            uint32_t hi = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            uint64_t dval = ((uint64_t)hi << 32) | lo;
            double d;
            memcpy(&d, &dval, 8);
            snprintf(formatted, sizeof(formatted), spec, d);
        } else {
            snprintf(formatted, sizeof(formatted), "%s", spec);
        }

        size_t flen = strlen(formatted);
        if (out_len + flen < sizeof(temp)) {
            memcpy(temp + out_len, formatted, flen);
            out_len += flen;
        } else {
            size_t avail = sizeof(temp) - 1 - out_len;
            memcpy(temp + out_len, formatted, avail);
            out_len += avail;
            break;
        }
    }

    temp[out_len] = '\0';
    if (out_len >= max_len) {
        memcpy(dst, temp, max_len - 1);
        dst[max_len - 1] = '\0';
    } else {
        memcpy(dst, temp, out_len + 1);
    }
    return (int)out_len;
}
void h_sprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    const char *fmt = (const char*)guest_to_host(c->r1);
    uint32_t reg_args[2] = { c->r2, c->r3 };
    c->r0 = (uint32_t)safe_guest_snprintf(dst, 1024, fmt, reg_args, 2, c->sp);
}
void h_snprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    uint32_t max_len = c->r1;
    const char *fmt = (const char*)guest_to_host(c->r2);
    uint32_t reg_args[1] = { c->r3 };
    c->r0 = (uint32_t)safe_guest_snprintf(dst, max_len, fmt, reg_args, 1, c->sp);
}
void h_vsprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    const char *fmt = (const char*)guest_to_host(c->r1);
    uint32_t va_sp = c->r2;
    c->r0 = (uint32_t)safe_guest_snprintf(dst, 1024, fmt, NULL, 0, va_sp);
}
void h_vsnprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    uint32_t max_len = c->r1;
    const char *fmt = (const char*)guest_to_host(c->r2);
    uint32_t va_sp = c->r3;
    c->r0 = (uint32_t)safe_guest_snprintf(dst, max_len, fmt, NULL, 0, va_sp);
}

#define MAX_SSCANF_ARGS 16

static int normalize_scanf_format(const char *fmt, char *out_fmt, size_t out_sz, int *out_num_args) {
    if (!fmt || !out_fmt || out_sz == 0) return -1;
    size_t o = 0;
    int arg_count = 0;
    const char *p = fmt;

    while (*p && o + 1 < out_sz) {
        if (*p != '%') {
            out_fmt[o++] = *p++;
            continue;
        }

        out_fmt[o++] = *p++;
        if (*p == '%') {
            if (o + 1 < out_sz) out_fmt[o++] = *p++;
            continue;
        }

        bool suppress = false;
        if (*p == '*') {
            suppress = true;
            if (o + 1 < out_sz) out_fmt[o++] = *p++;
        }

        while (*p >= '0' && *p <= '9') {
            if (o + 1 < out_sz) out_fmt[o++] = *p++;
            else break;
        }

        if (p[0] == 'l' && p[1] == 'l') {
            if (o + 2 < out_sz) {
                out_fmt[o++] = *p++;
                out_fmt[o++] = *p++;
            }
        } else if (*p == 'l') {
            char next = p[1];
            if (next == 'f' || next == 'F' || next == 'g' || next == 'G' || next == 'e' || next == 'E' || next == 'a' || next == 'A') {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            } else if (next == 'd' || next == 'i' || next == 'u' || next == 'x' || next == 'X' || next == 'o') {
                p++; // Strip 'l' so 64-bit host sscanf writes 4 bytes
            } else {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            }
        } else if (*p == 'z' || *p == 't') {
            p++;
        } else if (*p == 'h') {
            if (o + 1 < out_sz) out_fmt[o++] = *p++;
            if (*p == 'h') {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            }
        }

        if (*p == '[') {
            if (o + 1 < out_sz) out_fmt[o++] = *p++;
            if (*p == '^') {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            }
            if (*p == ']') {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            }
            while (*p && *p != ']') {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            }
            if (*p == ']') {
                if (o + 1 < out_sz) out_fmt[o++] = *p++;
            }
            if (!suppress) arg_count++;
        } else if (*p) {
            char spec = *p;
            if (o + 1 < out_sz) out_fmt[o++] = *p++;
            if (!suppress) {
                arg_count++;
            }
        }
    }
    out_fmt[o] = '\0';
    if (out_num_args) *out_num_args = arg_count;
    return 0;
}

void h_sscanf(hle_t *c) {
    const char *str = (const char*)guest_to_host(c->r0);
    const char *fmt = (const char*)guest_to_host(c->r1);
    if (!str || !fmt) {
        c->r0 = 0;
        return;
    }

    char norm_fmt[512];
    int num_args = 0;
    normalize_scanf_format(fmt, norm_fmt, sizeof(norm_fmt), &num_args);

    if (num_args > MAX_SSCANF_ARGS) {
        LOGE("h_sscanf: format has %d conversions, exceeding MAX_SSCANF_ARGS (%d): fmt='%s'",
             num_args, MAX_SSCANF_ARGS, fmt);
        num_args = MAX_SSCANF_ARGS;
    }

    void *args[MAX_SSCANF_ARGS] = {0};
    for (int i = 0; i < num_args; i++) {
        uint32_t gaddr = 0;
        if (i == 0) gaddr = c->r2;
        else if (i == 1) gaddr = c->r3;
        else {
            guest_mem_read(c->sp + (uint32_t)((i - 2) * 4), &gaddr, 4);
        }
        args[i] = gaddr ? guest_to_host(gaddr) : NULL;
    }

    int res = 0;
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wformat-security"
#endif
    switch (num_args) {
        case 0:  res = sscanf(str, norm_fmt); break;
        case 1:  res = sscanf(str, norm_fmt, args[0]); break;
        case 2:  res = sscanf(str, norm_fmt, args[0], args[1]); break;
        case 3:  res = sscanf(str, norm_fmt, args[0], args[1], args[2]); break;
        case 4:  res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3]); break;
        case 5:  res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4]); break;
        case 6:  res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5]); break;
        case 7:  res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6]); break;
        case 8:  res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]); break;
        case 9:  res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]); break;
        case 10: res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]); break;
        case 11: res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]); break;
        case 12: res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]); break;
        case 13: res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12]); break;
        case 14: res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13]); break;
        case 15: res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13], args[14]); break;
        default:
            res = sscanf(str, norm_fmt, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7],
                         args[8], args[9], args[10], args[11], args[12], args[13], args[14], args[15]);
            break;
    }
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic pop
#endif
    c->r0 = (uint32_t)res;
}

static void h_atoi(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    c->r0 = s ? (uint32_t)atoi(s) : 0;
}
static void h_atoll(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    hle_ret64(c, s ? (uint64_t)atoll(s) : 0);
}
static void h_strtod(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    if (!s) { hle_ret64(c, 0); return; }
    char *end = NULL;
    double d = strtod(s, &end);
    if (c->r1) {
        uint32_t *pe = guest_ptr(c->r1, 4);
        if (pe) *pe = c->r0 + (uint32_t)(end - s);
    }
    hle_retdouble(c, d);
}
static void h_strtok(hle_t *c) {
    char *s = c->r0 ? (char *)guest_ptr(c->r0, 1) : NULL;
    const char *d = guest_ptr(c->r1, 1);
    if (!d || (c->r0 && !s)) { c->r0 = 0; return; }
    char *r = strtok(s, d);
    c->r0 = r ? host_to_guest(r) : 0;
}

const hle_def_t g_hle_libc_string_defs[] = {
    {"malloc", h_malloc}, {"free", h_free}, {"calloc", h_calloc}, {"realloc", h_realloc},
    {"memcpy", h_memcpy}, {"memmove", h_memcpy}, {"memset", h_memset}, {"memcmp", h_memcmp},
    {"memchr", h_memchr}, {"strlen", h_strlen}, {"strcmp", h_strcmp}, {"strncmp", h_strncmp},
    {"strcasecmp", h_strcasecmp}, {"strncasecmp", h_strncasecmp}, {"strcpy", h_strcpy},
    {"strncpy", h_strncpy}, {"strcat", h_strcat}, {"strncat", h_strncat}, {"strchr", h_strchr},
    {"strrchr", h_strrchr}, {"strstr", h_strstr}, {"strdup", h_strdup}, {"strspn", h_strspn},
    {"strcspn", h_strcspn}, {"wcslen", h_wcslen},
    {"sprintf", h_sprintf}, {"snprintf", h_snprintf}, {"vsprintf", h_vsprintf}, {"vsnprintf", h_vsnprintf},
    {"sscanf", h_sscanf}, {"atoi", h_atoi}, {"atoll", h_atoll}, {"strtod", h_strtod}, {"strtok", h_strtok},
};

const size_t g_hle_libc_string_defs_count = sizeof(g_hle_libc_string_defs) / sizeof(g_hle_libc_string_defs[0]);

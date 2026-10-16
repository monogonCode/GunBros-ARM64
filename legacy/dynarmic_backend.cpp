#include "dynarmic_backend.h"

#include <memory>
#include <array>
#include <optional>
#include <cstring>
#include <android/log.h>

#include "dynarmic/interface/A32/a32.h"
#include "dynarmic/interface/A32/config.h"
#include "dynarmic/interface/halt_reason.h"

#define LOG_TAG "GunBrosDynarmic"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

static dynarmic_guest_to_host_fn g_g2h = nullptr;
static dynarmic_call_svc_fn g_svc_cb = nullptr;

static std::array<std::uint8_t*, Dynarmic::A32::UserConfig::NUM_PAGE_TABLE_ENTRIES> g_page_table;

class GunBrosCallbacks final : public Dynarmic::A32::UserCallbacks {
public:
    std::optional<std::uint32_t> MemoryReadCode(Dynarmic::A32::VAddr vaddr) override {
        if (!g_g2h) return std::nullopt;
        void *ptr = g_g2h(vaddr);
        if (!ptr) return std::nullopt;
        uint32_t val;
        std::memcpy(&val, ptr, sizeof(val));
        return val;
    }

    std::uint8_t MemoryRead8(Dynarmic::A32::VAddr vaddr) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        return ptr ? *reinterpret_cast<uint8_t*>(ptr) : 0;
    }
    std::uint16_t MemoryRead16(Dynarmic::A32::VAddr vaddr) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (!ptr) return 0;
        uint16_t val;
        std::memcpy(&val, ptr, sizeof(val));
        return val;
    }
    std::uint32_t MemoryRead32(Dynarmic::A32::VAddr vaddr) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (!ptr) return 0;
        uint32_t val;
        std::memcpy(&val, ptr, sizeof(val));
        return val;
    }
    std::uint64_t MemoryRead64(Dynarmic::A32::VAddr vaddr) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (!ptr) return 0;
        uint64_t val;
        std::memcpy(&val, ptr, sizeof(val));
        return val;
    }

    void MemoryWrite8(Dynarmic::A32::VAddr vaddr, std::uint8_t value) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (ptr) *reinterpret_cast<uint8_t*>(ptr) = value;
    }
    void MemoryWrite16(Dynarmic::A32::VAddr vaddr, std::uint16_t value) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (ptr) std::memcpy(ptr, &value, sizeof(value));
    }
    void MemoryWrite32(Dynarmic::A32::VAddr vaddr, std::uint32_t value) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (ptr) std::memcpy(ptr, &value, sizeof(value));
    }
    void MemoryWrite64(Dynarmic::A32::VAddr vaddr, std::uint64_t value) override {
        void *ptr = g_g2h ? g_g2h(vaddr) : nullptr;
        if (ptr) std::memcpy(ptr, &value, sizeof(value));
    }

    void InterpreterFallback(Dynarmic::A32::VAddr pc, size_t num_instructions) override {
        LOGE("InterpreterFallback: pc=0x%08x, count=%zu", pc, num_instructions);
    }

    void CallSVC(std::uint32_t swi) override;

    void ExceptionRaised(Dynarmic::A32::VAddr pc, Dynarmic::A32::Exception exception) override {
        LOGE("ExceptionRaised: pc=0x%08x, ex=%d", pc, static_cast<int>(exception));
    }

    void AddTicks(std::uint64_t) override {}
    std::uint64_t GetTicksRemaining() override { return UINT64_MAX; }
};

static GunBrosCallbacks g_callbacks;
static std::unique_ptr<Dynarmic::A32::Jit> g_jit;

void GunBrosCallbacks::CallSVC(std::uint32_t swi) {
    if (swi == 0xffff) {
        if (g_jit) g_jit->HaltExecution(Dynarmic::HaltReason::UserDefined1);
        return;
    }
    if (g_svc_cb) {
        g_svc_cb(swi);
    }
}

extern "C" {

void dynarmic_backend_init(dynarmic_guest_to_host_fn g2h, dynarmic_call_svc_fn svc_cb) {
    g_g2h = g2h;
    g_svc_cb = svc_cb;
    g_page_table.fill(nullptr);

    Dynarmic::A32::UserConfig conf;
    conf.callbacks = &g_callbacks;
    conf.arch_version = Dynarmic::A32::ArchVersion::v7;
    conf.enable_cycle_counting = false;
    conf.always_little_endian = true;
    conf.define_unpredictable_behaviour = true;
    conf.page_table = &g_page_table;
    conf.absolute_offset_page_table = false;
    conf.detect_misaligned_access_via_page_table = 0;
    conf.code_cache_size = 128 * 1024 * 1024; // 128 MB JIT cache

    g_jit = std::make_unique<Dynarmic::A32::Jit>(conf);
    LOGI("Dynarmic backend initialized successfully with 128MB cache!");
}

void dynarmic_backend_map(uint32_t guest_addr, uint32_t size, void *host_ptr) {
    uint64_t start_page = guest_addr >> 12;
    uint64_t end_page = ((uint64_t)guest_addr + size) >> 12;
    uint8_t *host_bytes = static_cast<uint8_t*>(host_ptr);
    for (uint64_t p = start_page; p < end_page && p < g_page_table.size(); p++) {
        g_page_table[p] = host_bytes + ((p - start_page) << 12);
    }
}

void dynarmic_backend_set_reg(int reg, uint32_t val) {
    if (g_jit && reg >= 0 && reg < 16) {
        g_jit->Regs()[reg] = val;
    }
}

uint32_t dynarmic_backend_get_reg(int reg) {
    if (g_jit && reg >= 0 && reg < 16) {
        return g_jit->Regs()[reg];
    }
    return 0;
}

void dynarmic_backend_set_cpsr(uint32_t val) {
    if (g_jit) g_jit->SetCpsr(val);
}

uint32_t dynarmic_backend_get_cpsr(void) {
    if (g_jit) return g_jit->Cpsr();
    return 0;
}

uint32_t dynarmic_backend_run(uint32_t entry) {
    if (!g_jit) return 0;
    bool is_thumb = (entry & 1) != 0;
    g_jit->Regs()[15] = entry & ~1u;
    uint32_t cpsr = g_jit->Cpsr();
    if (is_thumb) cpsr |= (1u << 5);
    else cpsr &= ~(1u << 5);
    g_jit->SetCpsr(cpsr);

    g_jit->ClearHalt(static_cast<Dynarmic::HaltReason>(~0u));
    g_jit->Run();
    return g_jit->Regs()[0];
}

void dynarmic_backend_halt(void) {
    if (g_jit) g_jit->HaltExecution(Dynarmic::HaltReason::UserDefined1);
}

bool dynarmic_backend_is_active(void) {
    return g_jit != nullptr;
}

}

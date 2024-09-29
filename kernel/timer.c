#include "timer.h"

#include "idt.h"
#include "util.h"

#include <stdint.h>

uint64_t ticks;
const uint32_t freq = 1000;

void on_tick(struct interrupt_registers *regs) {
    ++ticks;
}

void timer_initialize(void) {
    ticks = 0;
    irq_install_handler(0, on_tick);

    // 1.19318 MHz
    uint32_t divisor = 1193180 / freq;

    out_port_b(0x43, 0x36);
    out_port_b(0x40, (uint8_t)(divisor & 0xFF));
    out_port_b(0x40, (uint8_t)((divisor >> 8) & 0xFF));
}

uint64_t get_ticks(void) {
    return ticks;
}


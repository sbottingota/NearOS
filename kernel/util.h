#ifndef _KERNEL_UTIL_H
#define _KERNEL_UTIL_H

#include <stdint.h>

char in_port_b(uint16_t port);
void out_port_b(uint16_t port, uint8_t value);

struct interrupt_registers {
    uint32_t cr2;
    uint32_t ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_no, err_code;
    uint32_t eip, csm, eflags, useresp, ss;
};

#endif


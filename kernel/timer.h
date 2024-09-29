#ifndef _KERNEL_TIMER_H
#define _KERNEL_TIMER_H

#include <stdint.h>

void timer_initialize(void);
uint64_t get_ticks(void);

#endif


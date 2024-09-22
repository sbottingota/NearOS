#ifndef _KERNEL_TTY_H
#define _KERNEL_TTY_H

#include <stddef.h>

void terminal_initialize(void);
void terminal_putchar(char c);
int terminal_getchar(void);
void terminal_write(const char *data, size_t size);
void terminal_error(const char *data, size_t size);
void terminal_write_string(const char *str);
void terminal_error_string(const char *str);

#endif

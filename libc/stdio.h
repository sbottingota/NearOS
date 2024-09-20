#ifndef _STDIO_H
#define _STDIO_H

#include <stddef.h>
#include <stdarg.h>

#define EOF (-1)

int printf(const char * format, ...);
int sprintf(char *buffer, const char *format, ...);
int snprint(char *buffer, size_t count, const char *format, ...);
int vprint(const char *format, va_list va);

void putchar(char);
void puts(const char *);

#endif

#include "stdio.h"
#include "../string/string.h"

#include <tty.h>

void puts(const char *str) {
    terminal_write(str, strlen(str));
    terminal_putchar('\n');
}

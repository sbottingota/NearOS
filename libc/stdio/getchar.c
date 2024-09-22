#include <stdio.h>
#include <tty.h>

int getchar(void) {
    char c = terminal_getchar();
    terminal_putchar(c);
    return c;
}


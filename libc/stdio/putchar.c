#include <stdio.h>

#include <tty.h>

void putchar(char c) {
    terminal_putchar(c);
}

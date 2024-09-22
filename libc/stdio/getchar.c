#include <stdio.h>
#include <tty.h>

int getchar(void) {
    return terminal_getchar();
}


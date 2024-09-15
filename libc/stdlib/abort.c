#include <stdlib.h>
#include <string.h>

#include <tty.h>

__attribute__((__noreturn__))
void abort(void) {
    char error_msg[] = "kernel: panic: abort()\n";
    terminal_error(error_msg, strlen(error_msg));

    while(1) {}
    __builtin_unreachable();
}


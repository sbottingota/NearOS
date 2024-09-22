#include <stdio.h>
#include <tty.h>

char *gets(char *str) {
    char *c = str;
    while ((*c = terminal_getchar()) != '\n') {
        // if backspace is entered, and we are not at the start of buffer, delete previous char
        if (*c == '\b') {
            if (c != str) {
                *c = '\0';
                --c;
                putchar('\b');
            }
        } else {
            putchar(*c);
            ++c;
        }
    }

    putchar('\n');

    *c = '\0';

    return str;
}



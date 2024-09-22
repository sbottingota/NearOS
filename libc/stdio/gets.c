#include <stdio.h>

char *gets(char *str) {
    char *c = str;
    while ((*c = getchar()) != '\n') {
        // if backspace is entered, and we are not at the start of buffer, delete previous char
        if (*c == '\b') {
            if (c != str) {
                *c = '\0';
                --c;
            }
        } else {
            ++c;
        }
    }

    *c = '\0';

    return str;
}



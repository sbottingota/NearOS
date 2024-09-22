#include <stdio.h>

void main(void) {
    char buf[100];

    printf("Hello, world!\n");
    while (1) {
        puts(gets(buf));
    }

    // putchar(1/0);
}


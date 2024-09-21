#include <stdio.h>

void main(void) {
    printf("Hello, world!\n");
    for (float x = 0; x < 3; x += 0.1) {
        printf("%f\n", x);
    }
    // putchar(1/0);
}


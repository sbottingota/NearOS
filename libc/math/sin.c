#include <math.h>

double sin(double x) {
    asm ("fsin" : "=t" (x) : "0" (x));
    return x;
}


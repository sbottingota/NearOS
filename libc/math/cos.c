#include <math.h>

double cos(double x) {
    asm ("fcos" : "=t" (x) : "0" (x));
    return x;
}


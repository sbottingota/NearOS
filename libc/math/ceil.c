#include <math.h>

double ceil(double x) {
    return (long long) x == x ? x : (double)(long long) x + 1;
}


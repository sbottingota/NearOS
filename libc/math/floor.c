#include <math.h>

double floor(double x) {
    return (long long) x == x ? x : (double)(long long) x;
}


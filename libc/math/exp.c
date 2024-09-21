#include <math.h>

double exp(double x) {
    double sum = 1.0;
    double term = 1.0;

    for (int n = 1; n < MAX_ITER; ++n) {
        term *= x / (double) n;
        sum += term;
        ++n;
    }

    return sum;
}


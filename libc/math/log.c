#include <math.h>
#include <float.h>

// Using Newton's method, the iteration simplifies to (implementation) 
// which has cubic convergence to ln(x).
double log(double x) {
    double yn = x - 1.0;
    double yn1 = yn;

    for (int i = 0; i < MAX_ITER; ++i) {
        yn = yn1;
        yn1 = yn + 2 * (x - exp(yn)) / (x + exp(yn));
    }

    return yn1;
}


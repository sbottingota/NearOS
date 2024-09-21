#include <math.h>

double trunc(double x) {
    if (x > 0) return floor(x);
    else return ceil(x);
}


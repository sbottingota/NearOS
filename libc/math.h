#ifndef _MATH_H
#define _MATH_H

#define MAX_ITER 200

#define isinf(x) 0 // infinity not supported yet
#define isnan(x) 0 // nan not supported yet

double sin(double);
double cos(double);
double tan(double);

// TODO
/*
double asin(double);
double acos(double);
double atan(double);

double sinh(double);
double cosh(double);
double tanh(double);
*/

double exp(double);
double log(double);
double log10(double);
// double sqrt(double);
double pow(double, double);

double ceil(double);
double floor(double);
double trunc(double);
// double round(double);

double fabs(double);


#endif


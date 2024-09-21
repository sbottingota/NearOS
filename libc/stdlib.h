#ifndef _STDLIB_H
#define _STDLIB_H

__attribute__((__noreturn__))
void abort(void);

int atoi(const char *);
char *dtoa(char *, double); 
#define ftoa(s, n) dtoa(s, n)

int abs(int);

#endif


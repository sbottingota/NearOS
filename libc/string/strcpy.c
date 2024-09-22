#include <string.h>

char *strcpy(char *dstptr, char *srcptr) {
    while (*srcptr != '\0') { 
        *dstptr = *srcptr;
        ++srcptr;
        ++dstptr;
    }

    *dstptr = '\0';

	return dstptr;
}

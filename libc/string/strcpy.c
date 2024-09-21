#include <string.h>

char *strcpy(char *srcptr, char *dstptr) {
    while (*srcptr != '\0') { 
        *dstptr = *srcptr;
        ++srcptr;
        ++dstptr;
    }

    *dstptr = '\0';

	return dstptr;
}

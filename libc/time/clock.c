#include <time.h>
#include <timer.h>

clock_t clock(void) {
    return (clock_t) get_ticks();
}

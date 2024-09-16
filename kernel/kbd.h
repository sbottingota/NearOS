#ifndef _KERNEL_KBD_H
#define _KERNEL_KBD_H

#include <stdbool.h>

void kbd_initialize(void);
char parse_char(char scan_code);

char get_current_scan_code(void); // get what key is pressed
char get_current_press(void); // get if pressed down or released

bool is_printable(char c);

#endif

// If you are targeting the wrong os.
#if defined(__linux)
#error "You are not using a cross-compiler."
#endif

// If you are not targeting 32-bit ix86 target.
#if !defined(__i386)
#error "Code must be compiled with ix86-elf compiler."
#endif

#include "tty.h"

void kernel_main(void)
{
    terminal_initialize();
    terminal_writestring("Hello, world!\n");

    // test output
    /*
    terminal_writestring("abcdefg\nabcd\tefg\nabcd\vefg\nabcd\refg\nabcd\befg\n");

    for (int i = 100; i < 1000; ++i) {
        terminal_writestring("Hello, world! 1\n");
        for (int j = 0; j < 99999999; ++j) {
            __asm__("nop");
        }
        terminal_writestring("Hello, world! 2\n");
        for (int j = 0; j < 99999999; ++j) {
            __asm__("nop");
        }
        terminal_writestring("Hello, world! 3\n");
        for (int j = 0; j < 99999999; ++j) {
            __asm__("nop");
        }
    }
    */
}


# NearOS
A very (very very) rudimentary OS I am working on to compete with my friend's [far-os](https://github.com/far-os/os).

## Setup
You will need to install a cross compiler such as the one [from here](https://github.com/lordmilko/i686-elf-tools) to compile the code.
Once you have that, just run `make` to compile.

## Running
You can use an emulator such as [qemu](https://www.qemu.org/) to run it.
To boot from bin, run `qemu-system-i386 -kernel nearos.bin`. (Or just run `make qemu` to automatically run from bin.)  
To boot from iso, run `qemu-system-i383 -cdrom nearos.iso`.


## Uploading Code
By default, all the .c files in the program/ directory are compiled together, and then the `main` method is called (which should not take in or return any values).
To run code, replace the default program in program/main.c with your own.


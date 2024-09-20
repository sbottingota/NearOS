.DEFAULT_GOAL := nearos.iso
.PHONY: clean

LD=i686-elf-ld
NASM=nasm
AS=i686-elf-as
CC=i686-elf-gcc
CFLAGS=-std=gnu99 -ffreestanding -Wall -Wextra -O2

KERNEL_SRC=$(wildcard kernel/*)
LIBC_SRC=$(wildcard libc/**/*)
PROGRAM_SRC=$(wildcard program/*)

boot.o: boot.s
	$(AS) boot.s -o boot.o

libk.a: $(KERNEL_SRC)
	cd kernel && $(CC) -c *.c $(CFLAGS)
	cd kernel && for file in *.asm; do \
		$(NASM) -f elf32 $$file; \
	done
	$(AR) -rc $@ kernel/*.o
	ranlib $@

libc.a: $(LIBC_SRC) libk.a
	cd libc && $(CC) -c **/*.c $(CFLAGS) -I../kernel -I.
	$(AR) -rc $@ libc/*.o libk.a
	ranlib $@

program.o: $(PROGRAM_SRC) libc.a
	cd program && $(CC) -c $$(find -type f -iname *.c -print) $(CFLAGS) -I../libc/
	$(LD) -r program/*.o -o program.o libc.a

nearos.bin: linker.ld boot.o libc.a program.o
	$(CC) -T linker.ld -o nearos.bin boot.o program.o -ffreestanding -O2 -nostdlib -lgcc -L. -l:libk.a -l:libc.a

nearos.iso: nearos.bin grub.cfg	
	mkdir -p isodir/boot/grub
	cp nearos.bin isodir/boot/nearos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o nearos.iso isodir

qemu: nearos.bin
	qemu-system-i386 -kernel nearos.bin

clean:
	rm -f *.o *.bin *.iso *.a *.out
	rm -f **/*.o
	rm -rf isodir

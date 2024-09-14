.DEFAULT_GOAL := nearos.iso
.PHONY: clean

LD=i686-elf-ld
AS=i686-elf-as
CC=i686-elf-gcc
CFLAGS=-std=gnu99 -ffreestanding -Wall -Wextra -O2

KERNEL_SRC=$(wildcard kernel/*.c)
LIBC_SRC=$(wildcard libc/*.c)

boot.o: boot.s
	$(AS) boot.s -o boot.o

libc.a: $(LIBC_SRC)
	cd libc && $(CC) -c *.c $(CFLAGS)
	$(AR) -rc $@ libc/*.o
	ranlib $@

kernel.o: $(KERNEL_SRC)
	cd kernel && $(CC) -c *.c $(CFLAGS)
	$(LD) -r kernel/*.o -o kernel.o libc.a

nearos.bin: linker.ld boot.o libc.a kernel.o
	$(CC) -T linker.ld -o nearos.bin boot.o kernel.o -ffreestanding -O2 -nostdlib -lgcc	

nearos.iso: nearos.bin grub.cfg	
	mkdir -p isodir/boot/grub
	cp nearos.bin isodir/boot/nearos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o nearos.iso isodir

qemu: nearos.bin
	qemu-system-i386 -kernel nearos.bin

clean:
	rm -f *.o *.bin *.iso *.a
	rm -f **/*.o
	rm -rf isodir

.DEFAULT_GOAL := nearos.iso
.PHONY: clean

AS=i686-elf-as
CC=i686-elf-gcc

boot.o: boot.s
	$(AS) boot.s -o boot.o

kernel.o: kernel.c
	$(CC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

nearos.bin: linker.ld boot.o kernel.o
	$(CC) -T linker.ld -o nearos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc	

nearos.iso: nearos.bin grub.cfg	
	mkdir -p isodir/boot/grub
	cp nearos.bin isodir/boot/nearos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o nearos.iso isodir

qemu: nearos.bin
	qemu-system-i386 -kernel nearos.bin

clean:
	rm -f *.o *.bin *.iso
	rm -rf isodir

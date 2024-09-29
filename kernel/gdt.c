#include "gdt.h"

extern void gdt_flush(void *);
extern void set_protected_mode(void);

struct gdt_entry_struct gdt_entries[5];
struct gdt_ptr_struct gdt_ptr;

void gdt_initialize(void) {
    gdt_ptr.limit = (sizeof(struct gdt_entry_struct) * 5) - 1;
    gdt_ptr.base = (unsigned int) &gdt_entries;

    set_gdt_gate(0, 0, 0, 0, 0); // null segment
    set_gdt_gate(1, 0, 0xFFFFFFFF, 0x9A, 0xcF); // kernel code segment
    set_gdt_gate(2, 0, 0xFFFFFFFF, 0x92, 0xcF); // kernel data segment
    set_gdt_gate(3, 0, 0xFFFFFFFF, 0xFA, 0xcF); // user code segment
    set_gdt_gate(4, 0, 0xFFFFFFFF, 0xF2, 0xcF); // user data segment

    gdt_flush(&gdt_ptr);

    set_protected_mode();
}

void set_gdt_gate(uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t gran) {
    gdt_entries[num].base_low = (base & 0xFFFF);
    gdt_entries[num].base_middle = (base >> 16) & 0xFF;
    gdt_entries[num].base_high = (base >> 24) & 0xFF;

    gdt_entries[num].limit = (limit & 0xFFFF);
    gdt_entries[num].flags = (limit >> 16) & 0x0F;
    gdt_entries[num].flags |= (gran & 0xF0);

    gdt_entries[num].access = access;
}

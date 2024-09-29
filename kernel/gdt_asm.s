.section .text
.globl set_protected_mode
.globl gdt_flush

set_protected_mode:
    mov %cr0, %eax 
    or $1, %al # set PE (Protection Enable) bit in CR0 (Control Register 0)
    mov %eax, %cr0

gdt_flush:
    mov    0x4(%esp), %eax
    lgdtl  (%eax)
    mov    $0x10, %eax
    mov    %eax, %ds
    mov    %eax, %es
    mov    %eax, %fs
    mov    %eax, %gs
    mov    %eax, %ss
    ljmp   $0x8, $gdt_flush.flush

gdt_flush.flush:
    ret

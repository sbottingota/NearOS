.section .text
.globl gdt_flush

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

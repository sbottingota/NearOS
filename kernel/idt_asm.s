.section .text
.globl idt_flush

.macro isr_noerrcode x
    .globl isr\x
    isr\x:
        cli
        push $0
        push $\x
        jmp isr_common_stub
.endm

.macro isr_errcode x
    .globl isr\x
    isr\x:
        cli
        push \x
        jmp isr_common_stub
.endm

.macro irq x, y
    .globl irq\x
    irq\x:
        cli
        push $0
        push $\y
        jmp irq_common_stub
.endm

idt_flush:
    mov 0x4(%esp), %eax
    lidtl (%eax)
    sti
    ret

isr_common_stub:
    pusha
    mov %ds, %eax
    push %eax
    mov %cr2, %eax
    push %eax
    mov $0x10, %ax
    mov %eax, %ds
    mov %eax, %es
    mov %eax, %fs
    mov %eax, %gs
    push %esp
    call isr_handler
    add $0x8, %esp
    pop %ebx
    mov %ebx, %ds
    mov %ebx, %es
    mov %ebx, %fs
    mov %ebx, %gs
    popa
    add $0x8, %esp
    sti
    iret

irq_common_stub:
    pusha
    mov %ds, %eax
    push %eax
    mov %cr2, %eax
    push %eax
    mov $0x10, %ax
    mov %eax, %ds
    mov %eax, %es
    mov %eax, %fs
    mov %eax, %gs
    push %esp
    call irq_handler
    add $0x8, %esp
    pop %ebx
    mov %ebx, %ds
    mov %ebx, %es
    mov %ebx, %fs
    mov %ebx, %gs
    popa
    add $0x8, %esp
    sti
    iret

isr_noerrcode 0
isr_noerrcode 1
isr_noerrcode 2
isr_noerrcode 3
isr_noerrcode 4
isr_noerrcode 5
isr_noerrcode 6
isr_noerrcode 7

isr_errcode 8
isr_noerrcode 9 
isr_errcode 10
isr_errcode 11
isr_errcode 12
isr_errcode 13
isr_errcode 14
isr_noerrcode 15
isr_noerrcode 16
isr_noerrcode 17
isr_noerrcode 18
isr_noerrcode 19
isr_noerrcode 20
isr_noerrcode 21
isr_noerrcode 22
isr_noerrcode 23
isr_noerrcode 24
isr_noerrcode 25
isr_noerrcode 26
isr_noerrcode 27
isr_noerrcode 28
isr_noerrcode 29
isr_noerrcode 30
isr_noerrcode 31
isr_noerrcode 128
isr_noerrcode 177

irq 0, 32
irq   1,    33
irq   2,    34
irq   3,    35
irq   4,    36
irq   5,    37
irq   6,    38
irq   7,    39
irq   8,    40
irq   9,    41
irq  10,    42
irq  11,    43
irq  12,    44
irq  13,    45
irq  14,    46
irq  15,    47

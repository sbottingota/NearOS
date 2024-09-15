global gdt_flush

gdt_flush:
    MOV eax, [esp+4]
    LGDT [eax]

    ; update segment registers
    MOV eax, 0x10
    MOV ds, ax
    MOV es, ax
    MOV fs, ax
    MOV gs, ax
    MOV ss, ax
    JMP 0x08:.flush ; update cs using far jump (as you can't do it directly like the other ones)

.flush:
    RET

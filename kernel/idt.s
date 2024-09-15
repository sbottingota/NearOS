	.file	"idt.c"
	.text
	.align 16
	.globl	memset
	.type	memset, @function
memset:
.LFB0:
	.cfi_startproc
	movl	12(%esp), %edx
	movl	4(%esp), %eax
	movzbl	8(%esp), %ecx
	testl	%edx, %edx
	jle	.L1
	addl	%eax, %edx
	.align 16
.L3:
	movb	%cl, (%eax)
	addl	$1, %eax
	cmpl	%eax, %edx
	jne	.L3
.L1:
	rep ret
	.cfi_endproc
.LFE0:
	.size	memset, .-memset
	.align 16
	.globl	init_idt
	.type	init_idt, @function
init_idt:
.LFB1:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	movl	$idt_entries, %eax
	.align 16
.L7:
	movb	$0, (%eax)
	addl	$1, %eax
	cmpl	$idt_entries+2048, %eax
	jne	.L7
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	movl	$2047, %eax
	movl	$idt_entries, idt_ptr+2
	pushl	$17
	.cfi_def_cfa_offset 28
	pushl	$32
	.cfi_def_cfa_offset 32
	movw	%ax, idt_ptr
	call	out_port_b
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	$17
	.cfi_def_cfa_offset 28
	pushl	$160
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$32
	.cfi_def_cfa_offset 28
	pushl	$33
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$40
	.cfi_def_cfa_offset 28
	pushl	$161
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$4
	.cfi_def_cfa_offset 28
	pushl	$33
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$2
	.cfi_def_cfa_offset 28
	pushl	$161
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$17
	.cfi_def_cfa_offset 28
	pushl	$33
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$17
	.cfi_def_cfa_offset 28
	pushl	$161
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$33
	.cfi_def_cfa_offset 32
	call	out_port_b
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$161
	.cfi_def_cfa_offset 32
	call	out_port_b
	movl	$isr0, %eax
	movl	$-301989880, idt_entries+2
	movl	$-301989880, idt_entries+10
	movw	%ax, idt_entries
	shrl	$16, %eax
	movl	$-301989880, idt_entries+18
	movw	%ax, idt_entries+6
	movl	$isr1, %eax
	movl	$-301989880, idt_entries+26
	movw	%ax, idt_entries+8
	shrl	$16, %eax
	movl	$-301989880, idt_entries+34
	movw	%ax, idt_entries+14
	movl	$isr2, %eax
	movl	$-301989880, idt_entries+42
	movw	%ax, idt_entries+16
	shrl	$16, %eax
	movl	$-301989880, idt_entries+50
	movw	%ax, idt_entries+22
	movl	$isr3, %eax
	movl	$-301989880, idt_entries+58
	movw	%ax, idt_entries+24
	shrl	$16, %eax
	movl	$-301989880, idt_entries+66
	movw	%ax, idt_entries+30
	movl	$isr4, %eax
	movl	$-301989880, idt_entries+74
	movw	%ax, idt_entries+32
	shrl	$16, %eax
	movw	%ax, idt_entries+38
	movl	$isr5, %eax
	movw	%ax, idt_entries+40
	shrl	$16, %eax
	movw	%ax, idt_entries+46
	movl	$isr6, %eax
	movw	%ax, idt_entries+48
	shrl	$16, %eax
	movw	%ax, idt_entries+54
	movl	$isr7, %eax
	movw	%ax, idt_entries+56
	shrl	$16, %eax
	movw	%ax, idt_entries+62
	movl	$isr8, %eax
	movw	%ax, idt_entries+64
	shrl	$16, %eax
	movw	%ax, idt_entries+70
	movl	$isr9, %eax
	movw	%ax, idt_entries+72
	shrl	$16, %eax
	movw	%ax, idt_entries+78
	movl	$isr10, %eax
	movw	%ax, idt_entries+80
	shrl	$16, %eax
	movw	%ax, idt_entries+86
	movl	$isr11, %eax
	movl	$-301989880, idt_entries+82
	movw	%ax, idt_entries+88
	shrl	$16, %eax
	movl	$-301989880, idt_entries+90
	movw	%ax, idt_entries+94
	movl	$isr12, %eax
	movl	$-301989880, idt_entries+98
	movw	%ax, idt_entries+96
	shrl	$16, %eax
	movl	$-301989880, idt_entries+106
	movw	%ax, idt_entries+102
	movl	$isr13, %eax
	movl	$-301989880, idt_entries+114
	movw	%ax, idt_entries+104
	shrl	$16, %eax
	movl	$-301989880, idt_entries+122
	movw	%ax, idt_entries+110
	movl	$isr14, %eax
	movl	$-301989880, idt_entries+130
	movw	%ax, idt_entries+112
	shrl	$16, %eax
	movl	$-301989880, idt_entries+138
	movw	%ax, idt_entries+118
	movl	$isr15, %eax
	movl	$-301989880, idt_entries+146
	movw	%ax, idt_entries+120
	shrl	$16, %eax
	movl	$-301989880, idt_entries+154
	movw	%ax, idt_entries+126
	movl	$isr16, %eax
	movl	$-301989880, idt_entries+162
	movw	%ax, idt_entries+128
	shrl	$16, %eax
	movw	%ax, idt_entries+134
	movl	$isr17, %eax
	movw	%ax, idt_entries+136
	shrl	$16, %eax
	movw	%ax, idt_entries+142
	movl	$isr18, %eax
	movw	%ax, idt_entries+144
	shrl	$16, %eax
	movw	%ax, idt_entries+150
	movl	$isr19, %eax
	movw	%ax, idt_entries+152
	shrl	$16, %eax
	movw	%ax, idt_entries+158
	movl	$isr20, %eax
	movw	%ax, idt_entries+160
	shrl	$16, %eax
	movw	%ax, idt_entries+166
	movl	$isr21, %eax
	movw	%ax, idt_entries+168
	shrl	$16, %eax
	movw	%ax, idt_entries+174
	movl	$8, %eax
	movw	%ax, idt_entries+170
	movl	$-4608, %eax
	movl	$-301989880, idt_entries+178
	movw	%ax, idt_entries+172
	movl	$isr22, %eax
	movl	$-301989880, idt_entries+186
	movw	%ax, idt_entries+176
	shrl	$16, %eax
	movl	$-301989880, idt_entries+194
	movw	%ax, idt_entries+182
	movl	$isr23, %eax
	movl	$-301989880, idt_entries+202
	movw	%ax, idt_entries+184
	shrl	$16, %eax
	movl	$-301989880, idt_entries+210
	movw	%ax, idt_entries+190
	movl	$isr24, %eax
	movl	$-301989880, idt_entries+218
	movw	%ax, idt_entries+192
	shrl	$16, %eax
	movl	$-301989880, idt_entries+226
	movw	%ax, idt_entries+198
	movl	$isr25, %eax
	movl	$-301989880, idt_entries+234
	movw	%ax, idt_entries+200
	shrl	$16, %eax
	movl	$-301989880, idt_entries+242
	movw	%ax, idt_entries+206
	movl	$isr26, %eax
	movl	$-301989880, idt_entries+250
	movw	%ax, idt_entries+208
	shrl	$16, %eax
	movw	%ax, idt_entries+214
	movl	$isr27, %eax
	movw	%ax, idt_entries+216
	shrl	$16, %eax
	movw	%ax, idt_entries+222
	movl	$isr28, %eax
	movw	%ax, idt_entries+224
	shrl	$16, %eax
	movw	%ax, idt_entries+230
	movl	$isr29, %eax
	movw	%ax, idt_entries+232
	shrl	$16, %eax
	movw	%ax, idt_entries+238
	movl	$isr30, %eax
	movw	%ax, idt_entries+240
	shrl	$16, %eax
	movw	%ax, idt_entries+246
	movl	$isr31, %eax
	movw	%ax, idt_entries+248
	shrl	$16, %eax
	movw	%ax, idt_entries+254
	movl	$irq0, %eax
	movw	%ax, idt_entries+256
	shrl	$16, %eax
	movw	%ax, idt_entries+262
	movl	$irq1, %eax
	movl	$-301989880, idt_entries+258
	movw	%ax, idt_entries+264
	shrl	$16, %eax
	movl	$-301989880, idt_entries+266
	movw	%ax, idt_entries+270
	movl	$irq2, %eax
	movl	$-301989880, idt_entries+274
	movw	%ax, idt_entries+272
	shrl	$16, %eax
	movl	$-301989880, idt_entries+282
	movw	%ax, idt_entries+278
	movl	$irq3, %eax
	movl	$-301989880, idt_entries+290
	movw	%ax, idt_entries+280
	shrl	$16, %eax
	movl	$-301989880, idt_entries+298
	movw	%ax, idt_entries+286
	movl	$irq4, %eax
	movl	$-301989880, idt_entries+306
	movw	%ax, idt_entries+288
	shrl	$16, %eax
	movl	$-301989880, idt_entries+314
	movw	%ax, idt_entries+294
	movl	$irq5, %eax
	movl	$-301989880, idt_entries+322
	movw	%ax, idt_entries+296
	shrl	$16, %eax
	movl	$-301989880, idt_entries+330
	movw	%ax, idt_entries+302
	movl	$irq6, %eax
	movb	$0, idt_entries+340
	movw	%ax, idt_entries+304
	shrl	$16, %eax
	movw	%ax, idt_entries+310
	movl	$irq7, %eax
	movw	%ax, idt_entries+312
	shrl	$16, %eax
	movw	%ax, idt_entries+318
	movl	$irq8, %eax
	movw	%ax, idt_entries+320
	shrl	$16, %eax
	movw	%ax, idt_entries+326
	movl	$irq9, %eax
	movw	%ax, idt_entries+328
	shrl	$16, %eax
	movw	%ax, idt_entries+334
	movl	$irq10, %eax
	movw	%ax, idt_entries+336
	shrl	$16, %eax
	movw	%ax, idt_entries+342
	movl	$8, %eax
	movw	%ax, idt_entries+338
	movl	$irq11, %eax
	movb	$-18, idt_entries+341
	movw	%ax, idt_entries+344
	shrl	$16, %eax
	movl	$idt_ptr, (%esp)
	movw	%ax, idt_entries+350
	movl	$irq12, %eax
	movl	$-301989880, idt_entries+346
	movw	%ax, idt_entries+352
	shrl	$16, %eax
	movl	$-301989880, idt_entries+354
	movw	%ax, idt_entries+358
	movl	$irq13, %eax
	movl	$-301989880, idt_entries+362
	movw	%ax, idt_entries+360
	shrl	$16, %eax
	movl	$-301989880, idt_entries+370
	movw	%ax, idt_entries+366
	movl	$irq14, %eax
	movl	$-301989880, idt_entries+378
	movw	%ax, idt_entries+368
	shrl	$16, %eax
	movl	$-301989880, idt_entries+1026
	movw	%ax, idt_entries+374
	movl	$irq15, %eax
	movl	$-301989880, idt_entries+1418
	movw	%ax, idt_entries+376
	shrl	$16, %eax
	movw	%ax, idt_entries+382
	movl	$isr128, %eax
	movw	%ax, idt_entries+1024
	shrl	$16, %eax
	movw	%ax, idt_entries+1030
	movl	$isr177, %eax
	movw	%ax, idt_entries+1416
	shrl	$16, %eax
	movw	%ax, idt_entries+1422
	call	idt_flush
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	init_idt, .-init_idt
	.align 16
	.globl	set_idt_gate
	.type	set_idt_gate, @function
set_idt_gate:
.LFB2:
	.cfi_startproc
	movzbl	4(%esp), %eax
	movl	8(%esp), %edx
	movw	%dx, idt_entries(,%eax,8)
	shrl	$16, %edx
	movb	$0, idt_entries+4(,%eax,8)
	movw	%dx, idt_entries+6(,%eax,8)
	movl	12(%esp), %edx
	movw	%dx, idt_entries+2(,%eax,8)
	movzbl	16(%esp), %edx
	orl	$96, %edx
	movb	%dl, idt_entries+5(,%eax,8)
	ret
	.cfi_endproc
.LFE2:
	.size	set_idt_gate, .-set_idt_gate
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\nException! System Halted\n"
	.text
	.align 16
	.globl	isr_handler
	.type	isr_handler, @function
isr_handler:
.LFB3:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %eax
	movl	40(%eax), %eax
	cmpl	$31, %eax
	jbe	.L15
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.align 16
.L15:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	exception_messages(,%eax,4)
	.cfi_def_cfa_offset 32
	call	terminal_error_string
	movl	$.LC0, (%esp)
	call	terminal_error_string
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L13:
	jmp	.L13
	.cfi_endproc
.LFE3:
	.size	isr_handler, .-isr_handler
	.align 16
	.globl	irq_install_handler
	.type	irq_install_handler, @function
irq_install_handler:
.LFB4:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	8(%esp), %edx
	movl	%edx, irq_routines(,%eax,4)
	ret
	.cfi_endproc
.LFE4:
	.size	irq_install_handler, .-irq_install_handler
	.align 16
	.globl	irq_uninstall_handler
	.type	irq_uninstall_handler, @function
irq_uninstall_handler:
.LFB5:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	$0, irq_routines(,%eax,4)
	ret
	.cfi_endproc
.LFE5:
	.size	irq_uninstall_handler, .-irq_uninstall_handler
	.align 16
	.globl	irq_handler
	.type	irq_handler, @function
irq_handler:
.LFB6:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %ebx
	movl	40(%ebx), %eax
	movl	irq_routines-128(,%eax,4), %edx
	testl	%edx, %edx
	je	.L19
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	*%edx
	movl	40(%ebx), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L19:
	cmpl	$39, %eax
	jbe	.L20
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$32
	.cfi_def_cfa_offset 28
	pushl	$160
	.cfi_def_cfa_offset 32
	call	out_port_b
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L20:
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$32
	.cfi_def_cfa_offset 28
	pushl	$32
	.cfi_def_cfa_offset 32
	call	out_port_b
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE6:
	.size	irq_handler, .-irq_handler
	.globl	irq_routines
	.section	.bss
	.align 32
	.type	irq_routines, @object
	.size	irq_routines, 64
irq_routines:
	.zero	64
	.globl	exception_messages
	.section	.rodata.str1.1
.LC1:
	.string	"Division by Zero"
.LC2:
	.string	"Debug"
.LC3:
	.string	"Non Maskable Interrupt"
.LC4:
	.string	"Breakpoint"
.LC5:
	.string	"Intro Detected Overflow"
.LC6:
	.string	"Out of Bounds"
.LC7:
	.string	"Invalid Opcode"
.LC8:
	.string	"No Coprocesser"
.LC9:
	.string	"Alignment Fault"
.LC10:
	.string	"Machine Check"
.LC11:
	.string	"Reserved"
	.data
	.align 32
	.type	exception_messages, @object
	.size	exception_messages, 92
exception_messages:
	.long	.LC1
	.long	.LC2
	.long	.LC3
	.long	.LC4
	.long	.LC5
	.long	.LC6
	.long	.LC7
	.long	.LC8
	.long	.LC9
	.long	.LC10
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.long	.LC11
	.comm	idt_ptr,6,4
	.comm	idt_entries,2048,32
	.ident	"GCC: (GNU) 7.1.0"

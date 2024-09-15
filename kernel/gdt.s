	.file	"gdt.c"
	.text
	.align 16
	.globl	gdt_initialize
	.type	gdt_initialize, @function
gdt_initialize:
.LFB0:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	movl	$39, %eax
	movl	$gdt_entries, gdt_ptr+2
	pushl	$gdt_ptr
	.cfi_def_cfa_offset 32
	movw	%ax, gdt_ptr
	movl	$0, gdt_entries
	movl	$0, gdt_entries+4
	movl	$65535, gdt_entries+8
	movl	$13605376, gdt_entries+12
	movl	$65535, gdt_entries+16
	movl	$13603328, gdt_entries+20
	movl	$65535, gdt_entries+24
	movl	$13629952, gdt_entries+28
	movl	$65535, gdt_entries+32
	movl	$13627904, gdt_entries+36
	call	gdt_flush
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE0:
	.size	gdt_initialize, .-gdt_initialize
	.align 16
	.globl	set_gdt_gate
	.type	set_gdt_gate, @function
set_gdt_gate:
.LFB1:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	8(%esp), %edx
	movl	12(%esp), %ecx
	movl	16(%esp), %eax
	movl	%ecx, %ebx
	movw	%cx, gdt_entries+2(,%edx,8)
	shrl	$24, %ecx
	movb	%cl, gdt_entries+7(,%edx,8)
	movzbl	24(%esp), %ecx
	shrl	$16, %ebx
	movw	%ax, gdt_entries(,%edx,8)
	shrl	$16, %eax
	movb	%bl, gdt_entries+4(,%edx,8)
	andl	$15, %eax
	andl	$-16, %ecx
	orl	%ecx, %eax
	movb	%al, gdt_entries+6(,%edx,8)
	movl	20(%esp), %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	movb	%al, gdt_entries+5(,%edx,8)
	ret
	.cfi_endproc
.LFE1:
	.size	set_gdt_gate, .-set_gdt_gate
	.comm	gdt_ptr,6,4
	.comm	gdt_entries,40,32
	.ident	"GCC: (GNU) 7.1.0"

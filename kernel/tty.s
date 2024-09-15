	.file	"tty.c"
	.text
	.align 16
	.globl	terminal_initialize
	.type	terminal_initialize, @function
terminal_initialize:
.LFB2:
	.cfi_startproc
	movl	$0, terminal_row
	movl	$0, terminal_column
	movl	$753664, %eax
	movb	$-16, terminal_color
	movb	$-12, terminal_error_color
	movl	$753664, terminal_buffer
	.align 16
.L2:
	leal	160(%eax), %edx
	.align 16
.L3:
	movl	$-4064, %ecx
	addl	$2, %eax
	movw	%cx, -2(%eax)
	cmpl	%eax, %edx
	jne	.L3
	cmpl	$757664, %edx
	jne	.L2
	rep ret
	.cfi_endproc
.LFE2:
	.size	terminal_initialize, .-terminal_initialize
	.align 16
	.globl	terminal_setcolor
	.type	terminal_setcolor, @function
terminal_setcolor:
.LFB3:
	.cfi_startproc
	movl	4(%esp), %eax
	movb	%al, terminal_color
	ret
	.cfi_endproc
.LFE3:
	.size	terminal_setcolor, .-terminal_setcolor
	.align 16
	.globl	terminal_putentryat
	.type	terminal_putentryat, @function
terminal_putentryat:
.LFB4:
	.cfi_startproc
	movzbl	8(%esp), %edx
	movl	16(%esp), %eax
	leal	(%eax,%eax,4), %eax
	movl	%edx, %ecx
	movzbl	4(%esp), %edx
	sall	$8, %ecx
	sall	$4, %eax
	addl	12(%esp), %eax
	orl	%ecx, %edx
	movl	terminal_buffer, %ecx
	movw	%dx, (%ecx,%eax,2)
	ret
	.cfi_endproc
.LFE4:
	.size	terminal_putentryat, .-terminal_putentryat
	.align 16
	.globl	terminal_scrolltext
	.type	terminal_scrolltext, @function
terminal_scrolltext:
.LFB5:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	terminal_buffer, %ebx
	leal	3840(%ebx), %ecx
	movl	%ebx, %eax
	.align 16
.L10:
	movzwl	160(%eax), %edx
	addl	$2, %eax
	movw	%dx, -2(%eax)
	cmpl	%ecx, %eax
	jne	.L10
	movzbl	terminal_color, %ecx
	leal	4000(%ebx), %edx
	sall	$8, %ecx
	orl	$32, %ecx
	.align 16
.L11:
	movw	%cx, (%eax)
	addl	$2, %eax
	cmpl	%edx, %eax
	jne	.L11
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE5:
	.size	terminal_scrolltext, .-terminal_scrolltext
	.align 16
	.globl	terminal_putchar
	.type	terminal_putchar, @function
terminal_putchar:
.LFB6:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	12(%esp), %ecx
	movl	terminal_row, %edx
	leal	-8(%ecx), %eax
	cmpb	$5, %al
	ja	.L16
	movzbl	%al, %eax
	jmp	*.L18(,%eax,4)
	.section	.rodata
	.align 4
	.align 4
.L18:
	.long	.L17
	.long	.L19
	.long	.L31
	.long	.L21
	.long	.L16
	.long	.L22
	.text
	.align 16
.L17:
	movl	terminal_column, %eax
	testl	%eax, %eax
	je	.L25
	subl	$1, %eax
	movl	%eax, terminal_column
	.align 16
.L24:
	cmpl	$80, %eax
	jne	.L25
.L31:
	addl	$1, %edx
	movl	$0, terminal_column
	movl	%edx, terminal_row
.L25:
	cmpl	$25, %edx
	je	.L32
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 16
.L32:
	.cfi_restore_state
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	movl	$24, terminal_row
	jmp	terminal_scrolltext
	.align 16
.L22:
	.cfi_restore_state
	movl	$0, terminal_column
	jmp	.L25
	.align 16
.L19:
	movl	terminal_column, %eax
	addl	$4, %eax
	movl	%eax, terminal_column
	jmp	.L24
	.align 16
.L21:
	addl	$1, %edx
	movl	terminal_column, %eax
	movl	%edx, terminal_row
	jmp	.L24
	.align 16
.L16:
	movzbl	terminal_color, %esi
	movl	terminal_column, %eax
	leal	(%edx,%edx,4), %ebx
	movzbl	%cl, %ecx
	sall	$4, %ebx
	addl	%eax, %ebx
	addl	$1, %eax
	sall	$8, %esi
	orl	%esi, %ecx
	movl	terminal_buffer, %esi
	movw	%cx, (%esi,%ebx,2)
	movl	%eax, terminal_column
	jmp	.L24
	.cfi_endproc
.LFE6:
	.size	terminal_putchar, .-terminal_putchar
	.align 16
	.globl	terminal_write
	.type	terminal_write, @function
terminal_write:
.LFB7:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	16(%esp), %esi
	testl	%esi, %esi
	je	.L33
	movl	12(%esp), %ebx
	addl	%ebx, %esi
	.align 16
.L35:
	movsbl	(%ebx), %eax
	addl	$1, %ebx
	pushl	%eax
	.cfi_def_cfa_offset 16
	call	terminal_putchar
	cmpl	%ebx, %esi
	popl	%eax
	.cfi_def_cfa_offset 12
	jne	.L35
.L33:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE7:
	.size	terminal_write, .-terminal_write
	.align 16
	.globl	terminal_error
	.type	terminal_error, @function
terminal_error:
.LFB8:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	movzbl	terminal_error_color, %eax
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	20(%esp), %esi
	movzbl	terminal_color, %edi
	movb	%al, terminal_color
	testl	%esi, %esi
	je	.L42
	movl	16(%esp), %ebx
	addl	%ebx, %esi
	.align 16
.L43:
	movsbl	(%ebx), %eax
	addl	$1, %ebx
	pushl	%eax
	.cfi_def_cfa_offset 20
	call	terminal_putchar
	cmpl	%ebx, %esi
	popl	%eax
	.cfi_def_cfa_offset 16
	jne	.L43
.L42:
	movl	%edi, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	movb	%al, terminal_color
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE8:
	.size	terminal_error, .-terminal_error
	.align 16
	.globl	terminal_write_string
	.type	terminal_write_string, @function
terminal_write_string:
.LFB9:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	8(%esp), %ebx
	movsbl	(%ebx), %eax
	testb	%al, %al
	je	.L49
	.align 16
.L51:
	pushl	%eax
	.cfi_def_cfa_offset 12
	addl	$1, %ebx
	call	terminal_putchar
	movsbl	(%ebx), %eax
	popl	%edx
	.cfi_def_cfa_offset 8
	testb	%al, %al
	jne	.L51
.L49:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE9:
	.size	terminal_write_string, .-terminal_write_string
	.align 16
	.globl	terminal_error_string
	.type	terminal_error_string, @function
terminal_error_string:
.LFB10:
	.cfi_startproc
	movzbl	terminal_error_color, %eax
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	12(%esp), %ebx
	movzbl	terminal_color, %esi
	movb	%al, terminal_color
	movsbl	(%ebx), %eax
	testb	%al, %al
	je	.L58
	.align 16
.L59:
	pushl	%eax
	.cfi_def_cfa_offset 16
	addl	$1, %ebx
	call	terminal_putchar
	movsbl	(%ebx), %eax
	popl	%edx
	.cfi_def_cfa_offset 12
	testb	%al, %al
	jne	.L59
.L58:
	movl	%esi, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	movb	%al, terminal_color
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE10:
	.size	terminal_error_string, .-terminal_error_string
	.comm	terminal_buffer,4,4
	.comm	terminal_error_color,1,1
	.comm	terminal_color,1,1
	.comm	terminal_column,4,4
	.comm	terminal_row,4,4
	.ident	"GCC: (GNU) 7.1.0"

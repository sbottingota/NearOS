	.file	"util.c"
	.text
	.align 16
	.globl	out_port_b
	.type	out_port_b, @function
out_port_b:
.LFB0:
	.cfi_startproc
	movl	4(%esp), %edx
	movl	8(%esp), %eax
/APP
/  4 "util.c" 1
	outb $1 $0
/  0 "" 2
/NO_APP
	ret
	.cfi_endproc
.LFE0:
	.size	out_port_b, .-out_port_b
	.ident	"GCC: (GNU) 7.1.0"

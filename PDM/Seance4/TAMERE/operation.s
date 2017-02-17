.data

.text
.globl _start

_start:


addition:
	push %rbp
	movq %rsp, %rbp
	push %rbx
	movq 16(%rbp), %rbx
	movq 24(%rbp), %rax
	addq %rbx, %rax
	pop %rbx
	movq %rbp, %rsp
	pop %rbp
	ret
	

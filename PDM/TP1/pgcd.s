.data

nominateur:
    .long 13481754
denominateur:
    .long 1234715

pdcd:
    .space 4
.text
.globl _start

_start:
    mov $nominateur, %rdx
    mov $denominateur, %rbx

div:
    idiv %rbx
done:
    movl $0,%ebx
    movl $1,%eax
    int $0x80

.data
rtr:
    .byte 10
buff:
    .space 10
number:
    .int 260

.text
.globl _start
_start:
    mov $3, %rax
    mov $0, %rbx
    mov $buff, %rcx
    mov $10, %rdx
    int $0x80

    mov $buff, %r10
    movb (%r10), %r8b
    mov $48, %r9
    sub %r9, %r8

mknumber:
    add $1, %r10
    movb (%r10), %r11b
    
    mov $10, %r12b
    cmp %r11b, %r12b
    
    mov %r8, %r9
    je display
    
    mov $48, %r9
    sub %r9, %r11
    mov $10, %r13
    imul %r13, %r8
    add %r11, %r8
    jmp mknumber

display:
    

end:
    mov $0, %rbx
    mov $1, %rax
    int $0x80

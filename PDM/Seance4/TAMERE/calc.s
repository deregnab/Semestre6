/* Data Declaration */
.data
star:
    .ascii "*"

.bss
BUFF: /* The input string */
	.space 20

/* Code Declaration */
.text
.globl _start

_start:

read: /* Read the input */
	mov $3, %rax /* Call sys_read */
	mov $0, %rbx
	mov $BUFF, %rcx
	mov $20, %rdx /* Number of byte to read */
	int $0x80

init:
    mov %rax, %r10 /* Move the number of char read in R10 */
    dec %r10 /* Ignore the '\n' */
    mov $0, %r12 /* Initialize the final result in R12 */

atoi:
    movb (%rcx), %r9b /* Move the byte value pointed by the address in RCX */
    
    cmp $48, %r9 /* If R9 value < '0' */ /* 0 isn't RECOGNIZE */
    jle done /* Exit program */

    cmp $58, %r9 /* If R9 value > '9' */
    jge done /* Exit program */
    
    sub $48, %r9b /* Sub the '0' byte value */
    add %r9, %r12 /* Add R9 value to final result in R12 */

nextChar: /* Loop through all char of input */
    dec %r10
    jz step /* If R10 == 0, jump out the loop */
    
    imul $10, %r12 /* Multiply R12 by 10 */
    inc %rcx /* Go to next char */
    jmp atoi

step: /* For each char of BUFF */
	mov $1, %rax /* System call 1 is write */
	mov $1, %rdi /* File handle 1 is stdout */
	mov %r12, %rsi /* Address of string to output */
	mov $20, %rdx /* Number of bytes */
	syscall /* Invoke operating system to do the write */
    
#    dec %r12
#    jnz step /* If R12 != 0, jump back to step */

done:
	mov $60, %rax /* System call 60 is exit */
	xor %rdi, %rdi /* We want return code 0 */
	syscall /* Invoke operating system to exit */

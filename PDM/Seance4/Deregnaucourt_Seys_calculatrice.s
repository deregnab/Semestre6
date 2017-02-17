/*la valeur de retour du prog est le restult à l'afficher*/
.data
    ch1:
        .byte 0
    buff:
    	.space 20
    op:
        .byte 0
.text
.globl _start
_start:

    call read
    mov %r12, ch1

    dec %r10
    mov %rcx, op
    inc %rcx            /*on saute l'operande (toujours add pour le moment)*/


    call read
    /*appel a op*/
    add ch1, %r12

return:
    mov $1,%eax
    mov %r12, %rbx
    int $0x80


read:
    cmp $0, ch1         /*si deja lu, on passe à la conversion*/
    jnz conv

	mov $3, %rax       /*n° appel read*/
	mov $0, %rbx
	mov $buff, %rcx
	mov $20, %rdx      /*lire 20 octets*/
	int $0x80

init:
    mov %rax, %r10      /*met le nb d'octet réellement lus dans %r10*/
    dec %r10            /*ignore le '\n'*/
    xor %r12, %r12      /*%r12 sera le résultat final (il vaut donc 0 au départ)*/

conv:
    movb (%rcx), %r9b   /*1er octet lu dans %r9b (%rcx contient l'adresse de buff -> pointe les octets lus) en ascii donc*/

    cmp $48, %r9        /*si %r9 vaut moins de '0' c'est une err*/
    jl end_read_wd

    cmp $58, %r9        /*si %r9 vaut plus de '9' c'est une err*/
    jge end_read_wd

    sub $48, %r9b       /*transforme l'ascii en chiffre*/
    add %r9, %r12       /*met le chiffre dans le resultat final*/

next_char:
    dec %r10            /*il y a  1 ch en - a lire*/
    jz end_read           /*si il n'y a plus rien a lire on peut renvoyer*/

    imul $10, %r12      /*ajoute un 0 a droite en prévision de la prochaine lecture*/
    inc %rcx            /*incrémente le pointeur de buf -> on oublie le char qu'on vient de lire (on passe au suivant)*/
    jmp conv

end_read_wd:
    mov $0, %rdx
    mov %r12, %rax      /*dans le cas de l'operande on a multiplie par 10 une fois en trop*/
    mov $10, %r8
    idiv %r8
    mov %rax, %r12


end_read:
    ret


    .type addition, @function
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
    .type substract, @function
    substract:
    	push %rbp
    	movq %rsp, %rbp
    	push %rbx
    	movq 16(%rbp), %rbx
    	movq 24(%rbp), %rax
    	subq %rbx, %rax
    	pop %rbx
    	movq %rbp, %rsp
    	pop %rbp
    	ret
    .type multiplication, @function
    multiplication:
    	push %rbp
    	movq %rsp, %rbp
    	push %rbx
    	movq 16(%rbp), %rbx
    	movq 24(%rbp), %rax
    	imul %rbx, %rax
    	pop %rbx
    	movq %rbp, %rsp
    	pop %rbp
    	ret
    /*
    .type division, @function
    division:
        mov $0, %rdx
        mov %r12, %rax      
        mov $10, %rcx
        idiv %rcx
        mov %rax, %r12
    */

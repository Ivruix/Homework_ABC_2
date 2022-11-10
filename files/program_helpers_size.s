	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text
	.globl	generateString
	.type	generateString, @function
generateString:
	endbr64
	push	r13
	mov	r13d, 95
	push	r12
	lea	r12, str[rip]
	push	rbp
	mov	rbp, r12
	push	rbx
	push	rdx
	call	srand@PLT
	call	rand@PLT
	mov	ecx, 40000
	cdq
	idiv	ecx
	lea	ebx, 60000[rdx]
.L2:
	call	rand@PLT
	inc	rbp
	cdq
	idiv	r13d
	add	edx, 32
	mov	BYTE PTR -1[rbp], dl
	mov	eax, ebp
	sub	eax, r12d
	cmp	ebx, eax
	jg	.L2
	movsx	rbx, ebx
	mov	BYTE PTR [r12+rbx], 0
	pop	rax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	generateString, .-generateString
	.globl	countDigits
	.type	countDigits, @function
countDigits:
	endbr64
	lea	rdx, str[rip]
	xor	r8d, r8d
.L7:
	mov	al, BYTE PTR [rdx]
	test	al, al
	je	.L10
	sub	eax, 48
	cmp	al, 10
	adc	r8d, 0
	inc	rdx
	jmp	.L7
.L10:
	mov	eax, r8d
	ret
	.size	countDigits, .-countDigits
	.globl	countLetters
	.type	countLetters, @function
countLetters:
	endbr64
	lea	rdx, str[rip]
	xor	r8d, r8d
.L12:
	mov	al, BYTE PTR [rdx]
	test	al, al
	je	.L15
	and	eax, -33
	sub	eax, 65
	cmp	al, 26
	adc	r8d, 0
	inc	rdx
	jmp	.L12
.L15:
	mov	eax, r8d
	ret
	.size	countLetters, .-countLetters
	.globl	calculateElapsedTime
	.type	calculateElapsedTime, @function
calculateElapsedTime:
	endbr64
	imul	rdx, rdx, 1000000000
	imul	rdi, rdi, 1000000000
	add	rdx, rcx
	add	rdi, rsi
	mov	rax, rdx
	sub	rax, rdi
	ret
	.size	calculateElapsedTime, .-calculateElapsedTime
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

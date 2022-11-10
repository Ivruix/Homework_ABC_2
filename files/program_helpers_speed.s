	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	generateString
	.type	generateString, @function
generateString:
	endbr64
	push	r13
	push	r12
	lea	r12, str[rip]
	push	rbp
	mov	r13, r12
	push	rbx
	sub	rsp, 8
	call	srand@PLT
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1759218605
	sar	ecx, 31
	sar	rdx, 46
	sub	edx, ecx
	imul	ecx, edx, 40000
	sub	eax, ecx
	lea	ebx, 59999[rax]
	lea	ebp, 60000[rax]
	lea	rax, 1[r12]
	add	rbx, rax
	.p2align 4,,10
	.p2align 3
.L2:
	call	rand@PLT
	add	r13, 1
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, -1401515643
	sar	ecx, 31
	shr	rdx, 32
	add	edx, eax
	sar	edx, 6
	sub	edx, ecx
	imul	edx, edx, 95
	sub	eax, edx
	add	eax, 32
	mov	BYTE PTR -1[r13], al
	cmp	r13, rbx
	jne	.L2
	movsx	rbp, ebp
	mov	BYTE PTR [r12+rbp], 0
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	generateString, .-generateString
	.p2align 4
	.globl	countDigits
	.type	countDigits, @function
countDigits:
	endbr64
	movzx	eax, BYTE PTR str[rip]
	test	al, al
	je	.L10
	lea	rdx, str[rip+1]
	xor	r8d, r8d
	.p2align 4,,10
	.p2align 3
.L9:
	sub	eax, 48
	cmp	al, 10
	adc	r8d, 0
	movzx	eax, BYTE PTR [rdx]
	add	rdx, 1
	test	al, al
	jne	.L9
	mov	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L10:
	xor	r8d, r8d
	mov	eax, r8d
	ret
	.size	countDigits, .-countDigits
	.p2align 4
	.globl	countLetters
	.type	countLetters, @function
countLetters:
	endbr64
	movzx	eax, BYTE PTR str[rip]
	test	al, al
	je	.L16
	lea	rdx, str[rip+1]
	xor	r8d, r8d
	.p2align 4,,10
	.p2align 3
.L15:
	and	eax, -33
	sub	eax, 65
	cmp	al, 26
	adc	r8d, 0
	movzx	eax, BYTE PTR [rdx]
	add	rdx, 1
	test	al, al
	jne	.L15
	mov	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	xor	r8d, r8d
	mov	eax, r8d
	ret
	.size	countLetters, .-countLetters
	.p2align 4
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

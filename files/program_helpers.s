	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text
	.globl	generateString
	.type	generateString, @function
generateString:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	eax, DWORD PTR -20[rbp]
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1759218605
	shr	rdx, 32
	sar	edx, 14
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 40000
	sub	eax, ecx
	mov	edx, eax
	lea	eax, 60000[rdx]
	mov	DWORD PTR -8[rbp], eax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -1401515643
	shr	rdx, 32
	add	edx, eax
	sar	edx, 6
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 95
	sub	eax, ecx
	mov	edx, eax
	mov	eax, edx
	add	eax, 32
	mov	ecx, eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, str[rip]
	mov	BYTE PTR [rax+rdx], cl
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -8[rbp]
	jl	.L3
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	mov	BYTE PTR [rax+rdx], 0
	nop
	leave
	ret
	.size	generateString, .-generateString
	.globl	countDigits
	.type	countDigits, @function
countDigits:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L5
.L7:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 47
	jle	.L6
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 57
	jg	.L6
	add	DWORD PTR -4[rbp], 1
.L6:
	add	DWORD PTR -8[rbp], 1
.L5:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	jne	.L7
	mov	eax, DWORD PTR -4[rbp]
	pop	rbp
	ret
	.size	countDigits, .-countDigits
	.globl	countLetters
	.type	countLetters, @function
countLetters:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L10
.L14:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 64
	jle	.L11
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 90
	jle	.L12
.L11:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 96
	jle	.L13
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 122
	jg	.L13
.L12:
	add	DWORD PTR -4[rbp], 1
.L13:
	add	DWORD PTR -8[rbp], 1
.L10:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	jne	.L14
	mov	eax, DWORD PTR -4[rbp]
	pop	rbp
	ret
	.size	countLetters, .-countLetters
	.globl	calculateElapsedTime
	.type	calculateElapsedTime, @function
calculateElapsedTime:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
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

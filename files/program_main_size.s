	.file	"program_main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Input string: "
.LC1:
	.string	"Generated string: "
.LC2:
	.string	"r"
.LC3:
	.string	"Elapsed: %ld ns\n"
.LC4:
	.string	"w"
.LC5:
	.string	"%d\n"
.LC6:
	.string	"Total digits: %d\n"
.LC7:
	.string	"Total letters: %d\n"
.LC8:
	.string	"Total digits and letters: %d\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r14
	push	r13
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	ebx, edi
	sub	rsp, 32
	dec	edi
	jne	.L2
	lea	rsi, .LC0[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdx, QWORD PTR stdin[rip]
	jmp	.L12
.L2:
	cmp	ebx, 2
	jne	.L4
	mov	rdi, QWORD PTR 8[rsi]
	call	atoi@PLT
	mov	edi, eax
	call	generateString@PLT
	lea	rsi, .LC1[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rdi, str[rip]
	call	puts@PLT
	mov	edi, 10
	call	putchar@PLT
	jmp	.L3
.L4:
	or	eax, -1
	cmp	ebx, 3
	jne	.L1
	mov	rdi, QWORD PTR 8[rsi]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	rdx, rax
.L12:
	mov	esi, 100000
	lea	rdi, str[rip]
	call	fgets@PLT
.L3:
	mov	rsi, rsp
	mov	edi, 1
	mov	r14d, 1000
	call	clock_gettime@PLT
.L6:
	xor	eax, eax
	call	countDigits@PLT
	mov	r13d, eax
	xor	eax, eax
	call	countLetters@PLT
	mov	r12d, eax
	dec	r14d
	jne	.L6
	lea	rsi, 16[rsp]
	mov	edi, 1
	lea	r14d, 0[r13+r12]
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR 16[rsp]
	mov	rcx, QWORD PTR 24[rsp]
	mov	rdi, QWORD PTR [rsp]
	mov	rsi, QWORD PTR 8[rsp]
	call	calculateElapsedTime@PLT
	lea	rsi, .LC3[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	cmp	ebx, 3
	jne	.L7
	mov	rdi, QWORD PTR 16[rbp]
	lea	rsi, .LC4[rip]
	call	fopen@PLT
	mov	ecx, r13d
	lea	r13, .LC5[rip]
	mov	esi, 1
	mov	rbp, rax
	mov	rdx, r13
	mov	rdi, rax
	xor	eax, eax
	call	__fprintf_chk@PLT
	mov	ecx, r12d
	mov	rdx, r13
	mov	rdi, rbp
	mov	esi, 1
	xor	eax, eax
	call	__fprintf_chk@PLT
	mov	ecx, r14d
	mov	rdx, r13
	mov	esi, 1
	mov	rdi, rbp
	xor	eax, eax
	call	__fprintf_chk@PLT
	jmp	.L8
.L7:
	mov	edx, r13d
	lea	rsi, .LC6[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	edx, r12d
	mov	edi, 1
	xor	eax, eax
	lea	rsi, .LC7[rip]
	call	__printf_chk@PLT
	mov	edx, r14d
	mov	edi, 1
	xor	eax, eax
	lea	rsi, .LC8[rip]
	call	__printf_chk@PLT
.L8:
	xor	eax, eax
.L1:
	add	rsp, 32
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.size	main, .-main
	.globl	str
	.bss
	.align 32
	.type	str, @object
	.size	str, 100000
str:
	.zero	100000
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

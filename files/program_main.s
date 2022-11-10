	.file	"program_main.c"
	.intel_syntax noprefix
	.text
	.globl	str
	.bss
	.align 32
	.type	str, @object
	.size	str, 100000
str:
	.zero	100000
	.section	.rodata
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
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	cmp	DWORD PTR -84[rbp], 1
	jne	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR stdin[rip]
	mov	rdx, rax
	mov	esi, 100000
	lea	rax, str[rip]
	mov	rdi, rax
	call	fgets@PLT
	jmp	.L3
.L2:
	cmp	DWORD PTR -84[rbp], 2
	jne	.L4
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edi, eax
	call	generateString@PLT
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, str[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	edi, 10
	call	putchar@PLT
	jmp	.L3
.L4:
	cmp	DWORD PTR -84[rbp], 3
	jne	.L5
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, rax
	mov	esi, 100000
	lea	rax, str[rip]
	mov	rdi, rax
	call	fgets@PLT
	jmp	.L3
.L5:
	mov	eax, -1
	jmp	.L6
.L3:
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	DWORD PTR -12[rbp], 0
	jmp	.L7
.L8:
	mov	eax, 0
	call	countDigits@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	eax, 0
	call	countLetters@PLT
	mov	DWORD PTR -8[rbp], eax
	add	DWORD PTR -12[rbp], 1
.L7:
	cmp	DWORD PTR -12[rbp], 999
	jle	.L8
	lea	rax, -80[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	mov	rdx, QWORD PTR -72[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	calculateElapsedTime@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -84[rbp], 3
	jne	.L9
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	edx, DWORD PTR -4[rbp]
	mov	rax, QWORD PTR -40[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	edx, DWORD PTR -8[rbp]
	mov	rax, QWORD PTR -40[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	edx, DWORD PTR -4[rbp]
	mov	eax, DWORD PTR -8[rbp]
	add	edx, eax
	mov	rax, QWORD PTR -40[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	jmp	.L10
.L9:
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR -8[rbp]
	mov	esi, eax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	edx, DWORD PTR -4[rbp]
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	mov	esi, eax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
.L10:
	mov	eax, 0
.L6:
	leave
	ret
	.size	main, .-main
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

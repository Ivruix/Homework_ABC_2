	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text

	.globl	generateString
generateString:					# Функция generateString
	push	rbp				# Пролог функции
	mov	rbp, rsp
	
	mov	edi, eax			# srand(seed)
	call	srand@PLT
	
	call	rand@PLT			# str_size = 60000 + rand() % 40000 (str_size в r11d)
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
	mov	r11d, eax
	
	mov	ebx, 0				# i = 0 (i в ebx)

	jmp	.L2

.L3:
	call	rand@PLT			# str[i] = 32 + rand() % 95
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
	mov	eax, ebx
	lea	rdx, str[rip]
	mov	BYTE PTR [rax+rdx], cl
	
	add	ebx, 1				# i++

.L2:
	cmp	ebx, r11d			# Выход из цикла
	jl	.L3
	
	mov	eax, r11d			# str[str_size] = 0
	lea	rdx, str[rip]
	mov	BYTE PTR [rax+rdx], 0
	
	leave					# Эпилог функции
	ret

	.globl	countDigits
countDigits:					# Функция countDigits
	push	rbp				# Пролог функции
	mov	rbp, rsp
	
	mov	r11d, 0				# result = 0 (result в r11d)
	mov	ebx, 0				# i = 0 (i в ebx)
	jmp	.L5

.L7:
	mov	eax, ebx			# Проверка str[i] >= 48 && str[i] <= 57
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 47
	jle	.L6
	mov	eax, ebx
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 57
	jg	.L6
	
	add	r11d, 1				# result++

.L6:
	add	ebx, 1				# i++

.L5:
	mov	eax, ebx			# Проверка str[i] != 0
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	jne	.L7
	
	mov	eax, r11d			# Возврат result
	
	pop	rbp				# Эпилог функции
	ret

	.globl	countLetters
countLetters:					# Функция countLetters
	push	rbp				# Пролог функции
	mov	rbp, rsp
	
	mov	r11d, 0				# result = 0 (result в r11d)
	mov	ebx, 0				# i = 0 (i в ebx)
	jmp	.L10

.L14:
	mov	eax, ebx			# Проверка str[i] >= 65 && str[i] <= 90
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 64
	jle	.L11
	mov	eax, ebx
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 90
	jle	.L12

.L11:
	mov	eax, ebx			# Проверка str[i] >= 97 && str[i] <= 122
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 96
	jle	.L13
	mov	eax, ebx
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	al, 122
	jg	.L13

.L12:
	add	r11d, 1				# result++

.L13:
	add	ebx, 1				# i++

.L10:
	mov	eax, ebx			# Проверка str[i] != 0
	lea	rdx, str[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	jne	.L14

	mov	eax, r11d			# Возврат result
	
	pop	rbp				# Эпилог функции
	ret

	.globl	calculateElapsedTime
calculateElapsedTime:
	imul	rdx, rdx, 1000000000		# ns1 *= 1000000000
	
	imul	rdi, rdi, 1000000000		# ns2 *= 1000000000
	
	add	rdx, rcx			# ns1 += t1.tv_nsec
	
	add	rdi, rsi			# ns2 += t2.tv_nsec
	
	mov	rax, rdx			# ns2 - ns1
	sub	rax, rdi

	ret					# Эпилог функции

	.intel_syntax noprefix
	.text

	.globl	str				# Строка str
	.bss
	.align 32
	.size	str, 100000
str:
	.zero	100000

	.section	.rodata			# Строки для main
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
main:						# Функция main, в ней сложно использовать регистры процессора для хранения локальных переменных, т.к. в вызываемых функциях регистры тоже используются для хранения переменных
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 96
	
	mov	DWORD PTR -84[rbp], edi		# Загрузка argc (argc в -84[rbp])
	
	mov	QWORD PTR -96[rbp], rsi		# Загрузка argv (argv в -96[rbp])
	
	cmp	DWORD PTR -84[rbp], 1		# Проверка количетва параметров консоли
	jne	.L2
	
	lea	rdi, .LC0[rip]			# printf("Input string: ")
	mov	eax, 0
	call	printf@PLT
	
	mov	rdx, QWORD PTR stdin[rip]	# fgets(str, sizeof(str), stdin)
	mov	esi, 100000
	lea	rdi, str[rip]
	call	fgets@PLT
	
	jmp	.L3

.L2:
	cmp	DWORD PTR -84[rbp], 2		# Проверка количетва параметров консоли
	jne	.L4
	
	mov	rax, QWORD PTR -96[rbp]		# generateString(atoi(argv[1]))
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edi, eax
	call	generateString@PLT
	
	lea	rax, .LC1[rip]			# printf("Generated string: ")
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	lea	rdi, str[rip]			# puts(str)
	call	puts@PLT
	
	mov	edi, 10				# printf("\n")
	
	call	putchar@PLT
	jmp	.L3
.L4:
	cmp	DWORD PTR -84[rbp], 3		# Проверка количетва параметров консоли
	jne	.L5
	
	mov	rax, QWORD PTR -96[rbp]		# input = fopen(argv[1], "r")
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT

	mov	rdx, rax			# fgets(str, sizeof(str), input)
	mov	esi, 100000
	lea	rax, str[rip]
	mov	rdi, rax
	call	fgets@PLT
	
	jmp	.L3
.L5:
	mov	eax, -1				# Возврат -1
	jmp	.L6
.L3:
	lea	rsi, -64[rbp]			# clock_gettime(CLOCK_MONOTONIC, &t1)
	mov	edi, 1
	call	clock_gettime@PLT
	
	mov	r12d, 0				# i = 0 (i в r12d)
	jmp	.L7
.L8:
	call	countDigits@PLT			# digit_count = countDigits() (digit_count в -4[rbp])
	mov	DWORD PTR -4[rbp], eax
	
	call	countLetters@PLT		# letter_count = countLetters() (letter_count в -8[rbp])
	mov	DWORD PTR -8[rbp], eax
	
	add	r12d, 1				# i++
.L7:
	cmp	r12d, 999			# Выход из цикла
	jle	.L8
	
	lea	rsi, -80[rbp]			# clock_gettime(CLOCK_MONOTONIC, &t2);
	mov	edi, 1
	call	clock_gettime@PLT
	
	mov	rax, QWORD PTR -80[rbp]		# elapsed_time = calculateElapsedTime(t1, t2)
	mov	rdx, QWORD PTR -72[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	calculateElapsedTime@PLT
	
	mov	rsi, rax			# printf("Elapsed: %ld ns\n", elapsed_time)
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	
	cmp	DWORD PTR -84[rbp], 3		# Проверка количетва параметров консоли
	jne	.L9
	
	mov	rax, QWORD PTR -96[rbp]		# output = fopen(argv[2], "w") (output в -40[rbp])
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	
	mov	edx, DWORD PTR -4[rbp]		# fprintf(output, "%d\n", digit_count)
	mov	rax, QWORD PTR -40[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	
	mov	edx, DWORD PTR -8[rbp]		# fprintf(output, "%d\n", letter_count)
	mov	rax, QWORD PTR -40[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	
	mov	edx, DWORD PTR -4[rbp]		# fprintf(output, "%d\n", digit_count + letter_count)
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
	mov	eax, DWORD PTR -4[rbp]		# printf("Total digits: %d\n", digit_count)
	mov	esi, eax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	mov	eax, DWORD PTR -8[rbp]		# fprintf(output, "%d\n", letter_count)
	mov	esi, eax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	mov	edx, DWORD PTR -4[rbp]		# fprintf(output, "%d\n", digit_count + letter_count)
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	mov	esi, eax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT

.L10:
	mov	eax, 0				# Возврат 0

.L6:
	leave					# Эпилог функции
	ret

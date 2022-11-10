
# Отчёт по ИДЗ 2

## Об отчёте

**Вариант:** 16

**Задание:** Разработать программу, которая вычисляет количество цифр и букв в заданной ASCII-строке.

Данный отчёт разбит на блоки по оценкам для удобства проверки. Программа была разработана с учетом требований до оценки 9 включительно.

Все файлы, относящиеся к решению, находятся в папке **files**.

Тесты находятся в папке **tests**.

## Код программы на C и ассемблере

Для решения задачи были написаны файлы **program_main.c** и **program_helpers.c**.

 **program_main.c**:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void generateString(int seed);
extern int countDigits();
extern int countLetters();
extern int64_t calculateElapsedTime(struct timespec t1, struct timespec t2);

char str[100000];

int main(int argc, char** argv) {
    int digit_count, letter_count;
    FILE *input, *output;
    struct timespec t1;
    struct timespec t2;
    int64_t elapsed_time;
    
    if (argc == 1) {
        printf("Input string: ");
        fgets(str, sizeof(str), stdin);
    } else if (argc == 2) {
        generateString(atoi(argv[1]));
        printf("Generated string: ");
        puts(str);
    	printf("\n");
    } else if (argc == 3) {
        input = fopen(argv[1], "r");
        fgets(str, sizeof(str), input);
    } else {
        return -1;
    }
    
    clock_gettime(CLOCK_MONOTONIC, &t1);
    
    for (int i = 0; i < 1000; i++) {
        digit_count = countDigits();
    	letter_count = countLetters();
    }
    
    clock_gettime(CLOCK_MONOTONIC, &t2);
    
    elapsed_time = calculateElapsedTime(t1, t2);
    printf("Elapsed: %ld ns\n", elapsed_time);
    
    if (argc == 3) {
        output = fopen(argv[2], "w");
        fprintf(output, "%d\n", digit_count);
        fprintf(output, "%d\n", letter_count);
        fprintf(output, "%d\n", digit_count + letter_count);
    } else {
        printf("Total digits: %d\n", digit_count);
        printf("Total letters: %d\n", letter_count);
        printf("Total digits and letters: %d\n", digit_count + letter_count);
    }
}
```

 **program_helpers.c**:
 
```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern char str[100000];

void generateString(int seed) {
    srand(seed);
    int str_size = 60000 + rand() % 40000;

    for (int i = 0; i < str_size; i++) {
        str[i] = 32 + rand() % 95;
    }
    
    str[str_size] = 0;
}

int countDigits() {
    int result = 0;
    for (int i = 0; str[i] != 0; i++) {
        if (str[i] >= 48 && str[i] <= 57) {
            result++;
        }
    }
    
    return result;
}

int countLetters() {
    int result = 0;
    for (int i = 0; str[i] != 0; i++) {
        if ((str[i] >= 65 && str[i] <= 90) || (str[i] >= 97 && str[i] <= 122)) {
            result++;
        }
    }
    
    return result;
}

int64_t calculateElapsedTime(struct timespec t1, struct timespec t2) {
    int64_t ns1, ns2;

    ns1 = t1.tv_sec;
    ns1 *= 1000000000;
    ns1 += t1.tv_nsec;


    ns2 = t2.tv_sec;
    ns2 *= 1000000000;
    ns2 += t2.tv_nsec;

    return ns2 - ns1;
}
```

После компиляции и внесения изменений, описанных в следующих пунктах, получились файлы **program_main_modified.s** и **program_helpers_modified.s**.

**program_main_modified.s**:

```gas
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
```

**program_helpers_modified.s**:

```gas
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
```

## На оценку 4

- Программы были скомпилированы без оптимизирующих и отладочных опций, получились файлы **program_helpers.s** и **program_main.s**.
- Были добавлены комментарии.
- Были убраны лишние макросы (по типу endbr64, nop, cdqe, movsx).
- Получившиеся файлы были ассемблированы и скомпонованы. Получились файлы **program.out** и **program_modified.out**. 
- Исполняемые файлы были проверены на тестах из папки **tests**. Результаты обоих программ во всех случаях одинаковые и верные.

## На оценку 5

- Были использованы функции с передаче параметров (например, calculateElapsedTime).
- Были использованы локальные переменные (например, digit_count в main).
- Комментарии уже были добавлены.

## На оценку 6

- Был произведен рефакторинг для максимизирования использования регистров процессора.
- Были оптимизированы конструкции, в которых запись в регистр происходит через предварительную запись в другой регистр.
- Программа уже была проверена на тестах.
- Размер модифицированной программы равен `16480 B`, что меньше, чем изначальные `16592 B`.

## На оценку 7 и 8

 - Код был разбит на 2 единицы компиляции.
 - Был реализован следующий функционал:
	 - Задание файлов ввода и вывода (происходит, если в командной строке два параметра, это пути до фала ввода и вывода соответственно).
	 - Задание случайной строки (происходит, если в командной строке один параметр, это seed).
	 - Измерение времени выполнения программы.

- Программа была протестирована по времени:

| Количество символов  | Время выполнения |
|----------------------|------------------|
|          1           |      6943 ns     |
|          10          |      25087 ns    |
|         100          |     204720 ns    |
|         4e5          |      1.013 s     |

## На оценку 9

### Оптимизация по скорости

Из файлов **program_main.c** и **program_helpers.c** был сформирован код на ассемблере  (**program_main_speed.s** и **program_helpers_speed.s**) с помощью флага оптимизации по скорости. Полученные файлы были ассемблированы и скомпонованы, получился файл **program_speed.out**.

### Оптимизация по размеру

Аналогично был сформирован код на ассемблере  (**program_2_main_size.s** и **program_2_helpers_size.s**) с помощью флага оптимизации по размеру. Полученные файлы были ассемблированы и скомпонованы, получился файл **program_size.out**.

Сравнение полученных программ:

|                                         | program_modified | program_2_speed | program_2_size |
|-----------------------------------------|------------------|-----------------|----------------|
|        Размер ассемблерного кода        |      7793 B      |     5189 B      |     4419 B     |
|        Размер исполняемого файла        |     16480 B      |     16624 B     |     16616 B    |
| Производительность (на 100000 элементах)|      0.994 s     |      0.11 s     |      0.16 s    |

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

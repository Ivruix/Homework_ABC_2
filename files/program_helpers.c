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

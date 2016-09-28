#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#include "crc32.c"

const char characters[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
/*
 * Generate a random buffer from append two random strings
 */

void random_buffer(char* buf)
{
    int i;
    for (i = 0; i < 32; i++) {
        buf[i] = characters[rand() % 62];
    }
    buf[32] = '\0';
}

int main()
{
    const char plaintext[] = "8A922A44D95C6FF93CDBBF9B9D4F925D"; // text to hash
    size_t length = strlen(plaintext);
    uint32_t hash = crc32(0x0, &plaintext, length); // 0xf4dbdf21
    #pragma omp parallel
    {
        int seed = omp_get_thread_num();
        srand(time(NULL) * seed);
        int count = 0;
        while (count < 10000000) {
            count++;
            char buf[33];
            random_buffer((char*) &buf);
            uint32_t cmp = crc32(0x0, (char*) &buf, 32);
            if (cmp == hash) {
                printf("%s", (char*) &buf);
            }
        }
    }
}



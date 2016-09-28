/*
 *  A program to brute-force search space to find a collision
 *  hash of 2 values, with one fixed, that satisfy
 *  CRC32(x) == CRC32(y)
 *
 *  @author: Jonathan Lui
 *  @course: CPEN442
 *  @date: September 27, 2016
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h> // C OpenMP for parallelisation
#include "crc32.c"

int main() {
    const char plaintext[] = "0"; // text to hash
    size_t length = strlen(plaintext);

    uint32_t hash = crc32(0x0, &plaintext, length); // 0xf4dbdf21

    uint32_t i;
    #pragma omp parallel
    {
        #pragma omp for
            for (i = 1; i < UINT32_MAX; i++) {
                char* buf = malloc(5*sizeof(char));
                sprintf(buf, "%u", i);
                uint32_t cmp = crc32(0x0, buf, strlen(buf));
                if (cmp == hash)
                    printf("Collision found: %s\n", buf);
                free(buf);
            }
    }
    return 0;
}



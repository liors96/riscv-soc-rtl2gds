#include <stdio.h>
#include <stdlib.h>
#include <gpio.h>
#include <iosim.h>

//---------------------------------------------------------
#define MY_ID 316263664*10 
#define MY_N 22 
#define vec (*(volatile unsigned int (*)[MY_N])(0x00002000))
#define my_index_addr 0x00001ffc
#define done_flag_addr 0xffffffff
 
//---------------------------------------------------------

int main(void) { 
    int n = MY_N;
    unsigned int id = 316263664; // Ensure `id` is unsigned
    int index = -1;  // Initialize with an invalid index

    // Debug: Print pre-sorted vector
    printf("Pre-sorted Vector:\n");
    for (int i = 0; i < n; i++) {
        printf("vec[%d] = %u\n", i, vec[i]);
    }

    // Sorting
    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) { 		
            if (vec[j] > vec[j+1]) {
                unsigned int swap = vec[j];
                vec[j]   = vec[j+1];
                vec[j+1] = swap;
            }
        }
    }

    // Debug: Print post-sorted vector
    printf("Post-sorted Vector:\n");
    for (int i = 0; i < n; i++) {
        printf("vec[%d] = %u\n", i, vec[i]);
    }

    // Search for ID in the sorted array
    for (int i = 0; i < n; i++) {
        if (vec[i] == id) {
            index = i;
            break;
        }
    }

    if (index == -1) {
        printf("Error: ID not found.\n");
    } else {
        printf("ID found at index: %d\n", index);
    }

    // Write results to memory-mapped addresses
    *((volatile unsigned int *) my_index_addr) = index;
    *((volatile unsigned char *) done_flag_addr) = 1;

    return 0; 
}

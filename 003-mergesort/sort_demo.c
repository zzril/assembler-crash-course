#include <stddef.h>
#include <stdio.h>

#include "merge_sort.h"

// --------

static int array[] = { 8, 0, 2, 9, 6, 5, 7, 1, 3, 4, };
size_t array_size = sizeof(array) / sizeof(int);

// --------

static void print_array() {

	for(size_t i = 0; i < array_size; i++) {
		printf("%d ", array[i]);
	}
		puts("");	// newline

	return;
}

// --------

int main() {

    print_array();

    merge_sort(array, array_size);

    print_array();

    return 0;
}



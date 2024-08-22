#include <stdio.h>

#include "my_string.h"

// --------

static const char s[] = "Hello, world!";

// --------

int main() {

    puts(s);
    printf("Length: %lu\n", my_strlen(s));

    return 0;
}



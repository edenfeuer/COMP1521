// where_are_the_bits.c ... determine bit-field order
// COMP1521 Lab 03 Exercise
// Written by ...

#include <stdio.h>
#include <stdlib.h>

struct _bit_fields {
   unsigned int a : 4,
                b : 8,
                c : 20;
};

int main(void)
{
   struct _bit_fields x;

   printf("%lu\n",sizeof(x));

   return 0;
}

/* BRIAN'S COMMENTS
 *
 * This program prints the size of the struct defined in the program.
 * Write code here to determine conclusively which of the above layouts is used.
 */
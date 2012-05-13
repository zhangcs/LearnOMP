#include "omp.h"
#include "stdio.h"

void main(int argc, char *argv[]) 
{
 #pragma omp parallel    
 /* Simple Hello World example */
 {    
   printf("Hello, World!  \n");
 }
}

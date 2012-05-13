#include "omp.h"
#include "stdio.h"

void main(int argc, char *argv[])
{
 #pragma omp parallel num_threads(18)    
 /* Simple Hello World example - modified */
 {
    printf("Hello, World!, ThreadId=%d\n", omp_get_thread_num() );
 }
}

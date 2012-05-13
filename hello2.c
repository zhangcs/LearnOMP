#include "omp.h"
#include "stdio.h"
#define NUM_THREADS 4

void main(int argc, char *argv[]) 
{
   omp_set_num_threads(NUM_THREADS);
    
#pragma omp parallel
/* Simple Hello World example - modified */
   {  int id; 
      id = omp_get_thread_num();
      printf("Hello, World!  myid = %d\n", id);
   }
}

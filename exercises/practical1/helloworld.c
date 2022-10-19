#include <stdio.h>

int main (int argc, char *argv[]) {

    double my_data, my_result;

/* Turn it into an MPI program (need to insert in various locations) */

/* Experiment with Hello message in all processes and only in the master process */

   printf("Hello World\n");
   
/* Print out various information about MPI infrastructure */

/* Initialize different data in every MPI process depending on their rank */

   printf("I am process ... with data = %f\n", my_data)

/* Broadcast data from some process to all other processes */

/* Do some work with data (get result) and print data and result in every process */

}

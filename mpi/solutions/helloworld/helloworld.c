#include <stdio.h>
#include "mpi.h"

///////////////////
// MPI Hello World
///////////////////
//
// Classical example printing "Hello World" in several processes
//
// example usage:
//		compile: mpicc -o helloworld helloworld.c
//		run: mpirun -n 4 helloworld
//

int main (int argc, char *argv[]) {

   int rank, size;
   double my_data;
   
/* Turn it into an MPI program (initialise MPI) */

   MPI_Init(&argc, &argv); /* initialise MPI */
   MPI_Comm_size(MPI_COMM_WORLD, &size); /* Get the rank within the global communicator */
   MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* Get the total number of ranks within the global communicator */
   
   setbuf(stdout, NULL);

/* Experiment with Hello message in all processes and only in the master process */

   printf("Hello world from rank %d of size %d \n", rank, size);
   if (rank == 0) { /* Only rank == 0 should print */
     printf("Hello world from the master process rank %d of size %d \n", rank, size);
   }
   // fflush(stdout);  // Flush output to ensure it appears immediately

/* Properly shutdown MPI (finalise MPI) */

   MPI_Finalize();
}

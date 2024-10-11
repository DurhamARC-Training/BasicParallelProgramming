#include <stdio.h>
#include "mpi.h"

////////////
// MPI Hello World
////////////
//
// Classical example printing "Hello World" in several processes
// Bonuses: 1) Printing different data in different processes
//          2) Using barrier to wait until all previous commands (outputs) are executed before the next ones
//          3) Broadcasting data from one process to all processes
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

/* Wait for all processes within the global communicator to be executed until here before continuing further */

   MPI_Barrier(MPI_COMM_WORLD);

/* Initialize different data in every MPI process depending on their rank */

   my_data = rank + (1.0*rank)/size;
   printf("I am process %d of size %d with data=%4.2f before broadcasting\n", rank, size, my_data);
   // fflush(stdout);  // Flush output again

/* Broadcast data from rank 1 to all other ranks */

   MPI_Bcast(&my_data, 1, MPI_DOUBLE, 1, MPI_COMM_WORLD);
   printf("I am process %d of size %d with data=%4.2f after broadcasting\n", rank, size, my_data);
   // fflush(stdout);  // Flush output again

/* Properly shutdown MPI (finalise MPI) */

   MPI_Finalize();
}

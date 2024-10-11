#include <stdio.h>
#include "/* INSERT MISSING HEADER */"

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

    double my_data;

/* Turn it into an MPI program (initialise MPI) */   
   ; /* <-- INSERT MISSING MPI FUNCTION ON THIS LINE */
   MPI_Comm_rank(/*INSERT ARGUMENTS*/); /* Get the rank within the global communicator */
   MPI_Comm_size(/*INSERT ARGUMENTS*/); /* Get the total number of ranks within the global communicator */

/* Experiment with Hello message in all processes and only in the master process */

   printf("Hello world from rank %d of size %d \n"/*, INSERT VARIABLES */);
   if (/*INSERT CONDITION*/) { /* Only rank == 0 should print */
     printf("Hello world from the master process rank %d of size %d \n"/*, INSERT VARIABLES */);
   }
   fflush(stdout);  // Flush output to ensure it appears immediately
   
/* Wait for all processes to be executed until here before continuing further */

   ; /* INSERT MISSING MPI COMMAND */

/* Initialize different data in every MPI process depending on their rank */

   my_data = /* ASSIGN DIFFERENT VALUES DEPENDING ON RANK*/;
   printf("I am process %d of size %d with data=%4.2f before broadcasting\n" /*, INSERT VARIABLES */);

/* Broadcast data from rank 1 to all other ranks */

   MPI_Bcast(/*INSERT ARGUMENTS*/);
   printf("I am process %d of size %d with data=%4.2f after broadcasting\n" /*, INSERT VARIABLES */);

/* Properly shutdown MPI (finalise MPI) */
   ; /* <-- INSERT MISSING MPI FUNCTION ON THIS LINE */
}

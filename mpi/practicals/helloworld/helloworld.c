#include <stdio.h>
#include "/* INSERT MISSING HEADER */"

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

    double my_data;

/* Turn it into an MPI program (initialise MPI) */   
   ; /* <-- INSERT MISSING MPI FUNCTION ON THIS LINE */
   ; /* <-- INSERT Get the rank within the global communicator */
   ; /* <-- INSERT Get the total number of ranks within the global communicator */

/* Experiment with Hello message in all processes and only in the master process */

   printf("Hello world from rank %d of size %d \n"/*, INSERT VARIABLES */);
   if (/*INSERT CONDITION*/) { /* Only rank == 0 should print */
     printf("Hello world from the master process rank %d of size %d \n"/*, INSERT VARIABLES */);
   }
   fflush(stdout);  // Flush output to ensure it appears immediately
   
/* Properly shutdown MPI (finalise MPI) */
   ; /* <-- INSERT MISSING MPI FUNCTION ON THIS LINE */
}

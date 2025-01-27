#include <stdio.h>
#include "mpi.h"


////////////
//MPI_Abort
////////////
//
// Simple example that sets up certain number of MPI processes but only continues if 4 processes are used, otherwise
// use MPI_Abort to properly stop
//
// example usage:
//		compile: mpicc -o mpi_abort mpi_abort.c
//		run: mpirun -n 4 mpi_abort
//

int main(argc, argv)
int argc;
char **argv;
{
	int rank, size;

/* Turn it into an MPI program (initialise MPI) */   
    ; /* <-- INSERT MISSING MPI FUNCTION ON THIS LINE */
    
    MPI_Comm_rank(/*INSERT ARGUMENTS*/); //rank of the processor, root = 0
    MPI_Comm_size(/*INSERT ARGUMENTS*/); //number of processors
    
    if (size != 4) {
        MPI_Abort(/*INSERT ARGUMENTS*/); //abort properly with error code '1' if not using 4 processes
    }

    printf("hello I am process: %d, size should only be 4: %d\n"/*, INSERT VARIABLES */);

/* Properly shutdown MPI (finalise MPI) */
   ; /* <-- INSERT MISSING MPI FUNCTION ON THIS LINE */

	return 0;
}
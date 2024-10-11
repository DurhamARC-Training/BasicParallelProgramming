#include <stdio.h>
#include "/* INSERT MISSING HEADER */"


////////////
//MPI_Bcast
////////////
//
// int MPI_Bcast( void *buffer, int count, MPI_Datatype datatype, int root, MPI_Comm comm )
//
// This example simply uses MPI_Bcast to broadcast a read in value to all other processes from root process
//
// example usage:
//		compile: mpicc -o mpi_bcast mpi_bcast.c
//		run: mpirun -n 4 mpi_bcast
//
int main(argc, argv)
int argc;
char **argv;
{
	int rank, value;

/* Turn it into an MPI program (initialise MPI) */   
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: what rank is the current processor */

    if (rank == 0) {
        // if root process we read the value to broadcast
        printf("Enter a number to broadcast:\n");
	    scanf("%d", &value);
    } else {
    	printf("process %d: Before MPI_Bcast, value is %d\n", rank, value); 
	}

    // each processor calls MPI_Bcast, data is broadcast from root processor and ends up in everyone value variable
    // root process uses MPI_Bcast to broadcast the value, each other process uses MPI_Bcast to receive the broadcast value
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */

    printf("process %d: After MPI_Bcast, value is %d\n", rank, value);

/* Properly shutdown MPI (finalise MPI) */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */

	return 0;
}
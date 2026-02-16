#include <stdio.h>
#include "/* INSERT MISSING HEADER */"

////////////////
// MPI_Comm_rank
////////////////
//
// uses:
// int MPI_Comm_rank( MPI_Comm comm, int *rank ) 
//
// Simple example that outputs the process ID of each process using MPI_Comm_rank
//
// example usage:
//		compile: mpicc -o mpi_comm_rank mpi_comm_rank.c
//		run: mpirun -n 4 mpi_comm_rank
//

int main(argc, argv)
int argc;
char **argv;
{
	int rank, value;

/* Turn it into an MPI program (initialise MPI) */   
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
    ; /* <-- INSERT set rank of the current processor, root = 0, to rank variable */
    
    ; /* <-- INSERT OUTPUT HERE: output rank or process ID of the this process */

/* Properly shutdown MPI (finalise MPI) */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */

	return 0;
}
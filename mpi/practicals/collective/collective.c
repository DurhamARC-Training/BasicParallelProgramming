#include <stdio.h>
#include "/* INSERT MISSING HEADER */"

////////////
//MPI collective functions
////////////
//
// MPI_Allreduce(void *sbuf, void *rbuf, int count, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
// MPI_Scan(const void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
//
// This example computes 1) the global sum of all ranks of the processes and
// 2) a partial rank sum in each process
//
// example usage:
//		compile: mpicc -o collective collective.c
//		run: mpirun -n 4 collective
//

int main (int argc, char *argv[])
{

   int rank, size;
   int sum, part;
   int tag_ready=1;

    MPI_Status status;

/* Initialise MPI */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get rank */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get size */

/* Compute global sum of all ranks */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: */
    printf ("Rank %i:\tSum = %i\n", rank, sum);

/* Compute partial rank sum */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: */
    printf ("Rank %d:\tSum = %d\n", rank, sum);  

/* Output in natural order */
   /* CAUTION: Although the printing is initialized by the 
               MPI processes in the order of the ranks,
               it is not guaranteed that the merge of the stdout
               of the processes will keep this order
               on the common output of all MPI processes ! */

    if (rank != 0)   
    {
        ; /* <-- INSERT MISSING MPI FUNCTION HERE: */
    }

    if (rank != size - 1)
    {
        ; /* <-- INSERT MISSING MPI FUNCTION HERE: */
    }

    if (rank == 0)
        printf ("Rank %d sent %d\n", rank, sum);  
    else
        printf ("Rank %d received %d\n", rank, sum);  

/* Properly shutdown MPI (finalise MPI) */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
}

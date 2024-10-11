#include <stdio.h>
#include "mpi.h"

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
   MPI_Init(&argc, &argv);
   MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* get rank */
   MPI_Comm_size(MPI_COMM_WORLD, &size); /* get size */

/* Compute global sum of all ranks */
   MPI_Allreduce (&rank, &sum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);  
   printf ("Rank %i:\tSum = %i\n", rank, sum);
  
/* Compute partial rank sum */
   MPI_Scan (&rank, &part, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD ); 
   printf ("Rank %d:\tPartial sum = %d\n", rank, part);  

   /* Output in natural order */
   /* CAUTION: Although the printing is initialized by the 
               MPI processes in the order of the ranks,
               it is not guaranteed that the merge of the stdout
               of the processes will keep this order
               on the common output of all MPI processes ! */

   if (rank != 0)   
      MPI_Recv(&sum, 1, MPI_INT, rank - 1, tag_ready, MPI_COMM_WORLD, &status);

   if (rank != size - 1)
      MPI_Send(&sum, 1, MPI_INT, rank + 1, tag_ready, MPI_COMM_WORLD);

   if (rank == 0)
      printf ("Rank %d sent %d\n", rank, sum);  
   else
      printf ("Rank %d received %d\n", rank, sum);  

   MPI_Finalize();
}

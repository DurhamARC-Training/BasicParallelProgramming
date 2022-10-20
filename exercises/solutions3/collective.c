#include <stdio.h>
#include <mpi.h>


int main (int argc, char *argv[])
{
   int rank, size;
   int sum;
   int token;
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
   MPI_Scan (&rank, &sum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD ); 

   /* Output in natural order */
   /* CAUTION: Although the printing is initialized by the 
               MPI processes in the order of the ranks,
               it is not guaranteed that the merge of the stdout
               of the processes will keep this order
               on the common output of all MPI processes ! */

   if (rank != 0)   
   {
      MPI_Recv(&token, 1, MPI_INT, rank - 1, tag_ready, MPI_COMM_WORLD, &status);
   }

   printf ("Rank %d:\tSum = %d\n", rank, sum);  

   if (rank != size - 1)
   {
      MPI_Send(&token, 1, MPI_INT, rank + 1, tag_ready, MPI_COMM_WORLD);
   }

   MPI_Finalize();
}

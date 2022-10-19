#include <stdio.h>
#include <mpi.h>

int main (int argc, char *argv[]) {

   int rank, size;
   double my_data, my_result;
   
/* Turn it into an MPI program  (need to insert in various locations) */   
   MPI_Init(&argc, &argv); /* initialise MPI */
   MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* Get rank */
   MPI_Comm_size(MPI_COMM_WORLD, &size); /* Get size */
   
/* Experiment with Hello message in all processes and only in the master process */
   printf("Hello world from rank %d of size %d \n", rank, size);
   
   if (rank == 0) { /* Only rank == 0 should print */
     printf("Hello world from the master process rank %d of size %d \n", rank, size);
   }

/* Print out various information about MPI infrastructure */

/* Initialize different data in every MPI process depending on their rank */
   my_data = rank + (1.0*rank)/size;
   printf("I am process %d of size %d with data=%f\n", rank, size, my_data)

/* Broadcast data from some process to all other processes */

   /* broadcasting the content of variable "my_data" in process 1 */
   /* into variables "my_data" in all other processes: */
   MPI_Bcast(&my_data, 1, MPI_DOUBLE, 1, MPI_COMM_WORLD);

/* Do some work with data (get result) and print data and result in every process */
   my_result = 1.0 + my_data;
   printf("I am process %d of size %d with the data=%f and result=%f \n", 
                       rank,     size,       my_data,     my_result);

   MPI_Finalize(); /* finalise MPI */
}

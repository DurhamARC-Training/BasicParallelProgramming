#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main (int argc, char *argv[]) {
   int rank, size, i;
   int send,recv;
   MPI_Status status;
   
/* Initialise MPI */
   MPI_Init(&argc, &argv);
   MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* get rank */
   MPI_Comm_size(MPI_COMM_WORLD, &size); /* get size */
   
   if (size == 1) {
      printf ("Error: number of processors must be 2 or greater\n");
      MPI_Finalize();
      exit (1);
   }

/* Initialise data */
   send = 0;
   recv = 0;
   
   if (rank == 0) { send = 1; } /* initialise send buffer on the first processor */

/* Begin loop */
   for (i=0; i<10; i++) { /* repeat for 10 iterations */
      if (rank == 0) {
/* Blocking send on first processor to second */
         MPI_Ssend(&send, 1, MPI_INT, 1, 1, MPI_COMM_WORLD);
         printf ("Stage %d: sent %d on processor %d\n", 4*i+1, send, rank);
/* Blocking receive on first processor from second */    
         MPI_Recv(&recv, 1, MPI_INT, 1, 2, MPI_COMM_WORLD, &status);
         printf ("Stage %d: received %d on processor %d\n", 4*i+4, recv, rank);
         printf ("          adding 1 to receive buffer and placing in send buffer\n");
/* Alter data for next loop */
         send = recv + 1;
      } else if (rank == 1) {
/* Blocking receive on second processor from first */
         MPI_Recv(&recv, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, &status);
         printf ("Stage %d: received %d on processor %d\n", 4*i+2, recv, rank);
         printf ("          adding 1 to receive buffer and placing in send buffer\n");
/* Alter data to send back again */
         send = recv + 1;
/* Blocking send on first processor to second */
         MPI_Ssend(&send, 1, MPI_INT, 0, 2, MPI_COMM_WORLD);
         printf ("Stage %d: sent %d on processor %d\n", 4*i+3, send, rank);
      }
   }
/* End loop */

   MPI_Finalize(); /* finalise MPI */
}

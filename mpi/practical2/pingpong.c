#include <stdio.h>
#include <stdlib.h>
#include "/* <-- INSERT missing header here */"

int main (int argc, char *argv[]) {
   
    int rank, size, i;
    int send,recv;
    MPI_Status status;

    const int N = /* <-- SELECT between 1 and 10: how many iterations to play ping pong */;

    ; /* <-- INSERT initialisE MPI here */
    ; /* <-- /* INSERT get rank of the processor within the global communicator here */
    ; /* <-- /* INSERT get size of the global communicator here */

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
        ; /* <-- INSERT blocking MPI send command here */
        printf ("Stage %d: sent %d on processor %d\n", 4*i+1/*, INSERT VARIABLES */);

/* Blocking receive on first processor from second */    
        ; /* <-- INSERT MPI receive command here */
        printf ("Stage %d: received %d on processor %d\n", 4*i+4/*, INSERT VARIABLES */);
        printf ("          adding 1 to receive buffer and placing in send buffer\n");

/* Alter data for next loop */
        send = /* <-- INSERT alter the variable as described in the last printf command */

      } else if (rank == 1) {

/* Blocking receive on second processor from first */
        ; /* <-- INSERT MPI receive command here */
        printf ("Stage %d: received %d on processor %d\n", 4*i+2/*, INSERT VARIABLES */);
        printf ("          adding 1 to receive buffer and placing in send buffer\n");

/* Alter data to send back again */
        send = /* <-- INSERT alter the variable as described in the last printf command */

/* Blocking send on second processor to first */
        ; /* <-- INSERT blocking MPI send command here */
        printf ("Stage %d: sent %d on processor %d\n", 4*i+3/*, INSERT VARIABLES */);
      }
   }
/* End loop */

    ; /* <--INSERT shutdown MPI here */

}

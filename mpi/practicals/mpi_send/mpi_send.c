#include <stdio.h>
#include "/* INSERT MISSING HEADER */"


////////////
//MPI_Send
////////////
//
// uses:
// int MPI_Send(const void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm)
//
// This example sets up a ring of processes, the user gives a value and the root process sends the value
// to the next process. Each process then sends the value to the next process (by process ID) up to the end of the ring.
//
// example usage:
//		compile: mpicc -o mpi_send mpi_send.c
//		run: mpirun -n 4 mpi_send
//
int main(argc, argv)
int argc;
char **argv;
{
	int rank, value, size;
    MPI_Status status;

/* Turn it into an MPI program (initialise MPI) */   
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
 
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get the number of processes that are running */

    do { 
        if (rank == 0) {
            printf("Enter a number to send (input negative to stop):\n");
            scanf("%d",&value);
            ; /* <-- INSERT MISSING MPI FUNCTION HERE: the root process sends the read-in value to next process (by ID) */
        } else {
            ; /* <-- INSERT MISSING MPI FUNCTION HERE: every process except to the root receives the sent value from the previous process ID */
            
            if (rank < size-1)
                ; /* <-- INSERT MISSING MPI FUNCTION HERE: each process sends the value to the next process by ID */
        
            printf("Process %d got %d\n", rank, value);  //the received value
        }
    } while (value >= 0); //keep going until user inputs negative number

/* Properly shutdown MPI (finalise MPI) */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */

	return 0;
}
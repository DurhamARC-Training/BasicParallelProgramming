#include <stdio.h>
#include "/* INSERT MISSING HEADER */"


////////////
//MPI_Isend
////////////
//
// int MPI_Isend(const void *buf, int count, MPI_Datatype datatype, int dest, int tag,
//              MPI_Comm comm, MPI_Request *request)
//
// This example uses MPI_Isend to do a non-blocking send of information from the root process to a destination process.
// The destination process is set as a variable in the code and must be less than the number of processes started.
//
// example usage:
//		compile: mpicc -o mpi_isend mpi_isend.c
//		run: mpirun -n 4 mpi_isend
//
int main(argc, argv)
int argc;
char **argv;
{
	int rank, size;
    int tag, destination, count;
    int buffer; //value to send

    tag = 1234;
    destination = 2; //destination process
    count = 1; //number of elements in buffer    

    MPI_Status status;
    MPI_Request request = MPI_REQUEST_NULL;

/* Turn it into an MPI program (initialise MPI) */   
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
 
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get the number of processes that are running */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process */

    if (destination >= size) {
        ; /* <-- INSERT MISSING MPI FUNCTION HERE: destination process must be under the number of processes created, otherwise abort */
    }

    if (rank == 0) {
        printf("Enter a value to send to processor %d:\n", destination);
        scanf("%d", &buffer);
        ; /* <-- INSERT MISSING MPI FUNCTION HERE: non blocking send to destination process */
    }

    if (rank == destination) {
        ; /* <-- INSERT MISSING MPI FUNCTION HERE: destination process receives */
    }

   ; /* <-- INSERT MISSING MPI FUNCTION HERE: blocks and waits for destination process to receive data */

    if (rank == 0) {
        printf("processor %d sent %d\n", rank, buffer);
    }
    if (rank == destination) {
        printf("processor %d got %d\n", rank, buffer);
    }

/* Properly shutdown MPI (finalise MPI) */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */

	return 0;
}
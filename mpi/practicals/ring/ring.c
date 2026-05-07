#include <stdio.h>
#include "/* INSERT MISSING HEADER */"

////////
// Ring
////////
//
// This example sets up a ring of processes where each process sends a value
// to the next process and receives a value from the previous process.
//
// To avoid deadlock or serialization, use a non-blocking synchronous send.
//
// example usage:
//      compile: mpicc -o ring ring.c
//      run: mpirun -n 4 ring
//

int main(argc, argv)
int argc;
char **argv;
{
	int snd_buf, rcv_buf, sum;
	int right, left;
	int i, my_rank, size;
	MPI_Status status;
	MPI_Request request;

/* Turn it into an MPI program (initialise MPI) */
	; /* <-- INSERT MISSING MPI FUNCTION HERE */
	; /* <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process */
	; /* <-- INSERT MISSING MPI FUNCTION HERE: get the number of processes that are running */

	right = (my_rank + 1) % size;
	left  = (my_rank - 1 + size) % size;
	sum = 0;
	snd_buf = my_rank;

	for (i = 0; i < size; i++) {
		/* Synchronous Issend is used only to demonstrate the use of the
		 * nonblocking routine to resolve the deadlock (or serialization)
		 * problem. A real application would use standard Isend(). */
		; /* <-- INSERT MISSING MPI FUNCTION HERE: non-blocking synchronous send to right neighbour */
		; /* <-- INSERT MISSING MPI FUNCTION HERE: receive from left neighbour */
		; /* <-- INSERT MISSING MPI FUNCTION HERE: wait for non-blocking send to complete */
		snd_buf = rcv_buf;
		sum += rcv_buf;
	}

	printf("PE%i:\tSum = %i\n", my_rank, sum);

/* Properly shutdown MPI (finalise MPI) */
	; /* <-- INSERT MISSING MPI FUNCTION HERE */

	return 0;
}

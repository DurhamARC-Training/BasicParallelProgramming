#include <stdio.h>
#include "/* INSERT MISSING HEADER */"

////////////
// MPI_Send
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
    FILE *input_file = NULL;

/* Turn it into an MPI program (initialise MPI) */   
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE: get the number of processes that are running */

    // Open input file once at the beginning (only for rank 0)
    if (rank == 0) {
        input_file = fopen("input.txt", "r");
        if (!input_file) {
            printf("Warning: Could not open input.txt, will exit immediately\n");
        }
    }

    do { 
        if (rank == 0) {
            printf("Enter a number to send (input negative to stop):\n");
            if (input_file && fscanf(input_file, "%d", &value) == 1) {
                printf("Read value: %d\n", value);
            } else {
                value = -1; // set negative value to trigger loop exit
            }
            ; /* <-- INSERT MISSING MPI FUNCTION HERE: the root process sends the read-in value to next process (by ID) */
        } else {
            ; /* <-- INSERT MISSING MPI FUNCTION HERE: every process except to the root receives the sent value from the previous process ID */
            
            if (rank < size-1)
                ; /* <-- INSERT MISSING MPI FUNCTION HERE: each process sends the value to the next process by ID */
        
            printf("Process %d got %d\n", rank, value);  // the received value
        }
    } while (value >= 0); // keep going until user inputs negative number

    // Close input file at the end
    if (rank == 0 && input_file) {
        fclose(input_file);
    }

/* Properly shutdown MPI (finalise MPI) */
    ; /* <-- INSERT MISSING MPI FUNCTION HERE */

	return 0;
}
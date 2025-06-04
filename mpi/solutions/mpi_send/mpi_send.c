#include <stdio.h>
#include "mpi.h"


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
    FILE *input_file = NULL;

    MPI_Init(&argc, &argv);
 
    MPI_Comm_rank(MPI_COMM_WORLD, &rank); //get the rank or ID of the current process
    MPI_Comm_size(MPI_COMM_WORLD, &size); //number of processes that are running

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
                value = -1; // Default to exit if file reading fails or EOF
            }
            MPI_Send(&value,1,MPI_INT,rank+1,0,MPI_COMM_WORLD); // the root process sends the read-in value to next process (by ID)
        } else {
            MPI_Recv(&value,1,MPI_INT,rank-1,0,MPI_COMM_WORLD,&status); // every process except to the root receives the sent value from the previous process ID
            
            if (rank < size-1)
                MPI_Send(&value,1,MPI_INT,rank+1,0,MPI_COMM_WORLD); // each process sends the value to the next process by ID
        
            printf("Process %d got %d\n",rank, value);  //the received value
        }
    } while (value >= 0); //keep going until user inputs negative number

    // Close input file at the end
    if (rank == 0 && input_file) {
        fclose(input_file);
    }

    MPI_Finalize();

    return 0;
}
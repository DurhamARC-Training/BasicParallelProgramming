#include <stdio.h>
#include "mpi.h"


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
    FILE *input_file = NULL;

    tag = 1234;
    destination = 2; //destination process
    count = 1; //number of elements in buffer    

    MPI_Status status;
    MPI_Request request = MPI_REQUEST_NULL;

    MPI_Init(&argc, &argv);

    MPI_Comm_size(MPI_COMM_WORLD, &size); //number of processes
    MPI_Comm_rank(MPI_COMM_WORLD, &rank); //rank of current process

    if (destination >= size) {
        MPI_Abort(MPI_COMM_WORLD, 1); // destination process must be under the number of processes created, otherwise abort
    }

    // Open input file once at the beginning (only for rank 0)
    if (rank == 0) {
        input_file = fopen("input.txt", "r");
        if (!input_file) {
            printf("Warning: Could not open input.txt, will use default value\n");
            buffer = 42; // Default value
        } else {
            printf("Enter a value to send to processor %d:\n", destination);
            if (fscanf(input_file, "%d", &buffer) == 1) {
                printf("Read value: %d\n", buffer);
            } else {
                printf("Failed to read from input.txt, using default value\n");
                buffer = 42; // Default value
            }
            fclose(input_file);
        }
        MPI_Isend(&buffer, count, MPI_INT, destination, tag, MPI_COMM_WORLD, &request); //non blocking send to destination process
        // MPI_Send(&buffer, count, MPI_INT, destination, tag, MPI_COMM_WORLD); //blocking send to destination process
    }

    if (rank == destination) {
        MPI_Irecv(&buffer, count, MPI_INT, 0, tag, MPI_COMM_WORLD, &request); //destination process receives
        // MPI_Recv(&buffer, count, MPI_INT, 0, tag, MPI_COMM_WORLD, &status); //destination process receives
    }

    MPI_Wait(&request, &status); //blocks and waits for destination process to receive data

    if (rank == 0) {
        printf("processor %d sent %d\n", rank, buffer);
    }
    if (rank == destination) {
        printf("processor %d got %d\n", rank, buffer);
    }

    MPI_Finalize();

    return 0;
}
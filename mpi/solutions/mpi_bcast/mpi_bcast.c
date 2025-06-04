#include <stdio.h>
#include "mpi.h"


////////////
//MPI_Bcast
////////////
//
// int MPI_Bcast( void *buffer, int count, MPI_Datatype datatype, int root, MPI_Comm comm )
//
// This example simply uses MPI_Bcast to broadcast a read in value to all other processes from root process
//
// example usage:
//		compile: mpicc -o mpi_bcast mpi_bcast.c
//		run: mpirun -n 4 mpi_bcast
//
int main(argc, argv)
int argc;
char **argv;
{
    int rank, value;
    FILE *input_file = NULL;

    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank); //what rank is the current processor

    if (rank == 0) {
        // if root process we read the value to broadcast from file
        input_file = fopen("input.txt", "r");
        if (!input_file) {
            printf("Warning: Could not open input.txt, using default value\n");
            value = 42; // Default value
        } else {
            printf("Enter a number to broadcast:\n");
            if (fscanf(input_file, "%d", &value) == 1) {
                printf("Read value: %d\n", value);
            } else {
                printf("Failed to read from input.txt, using default value\n");
                value = 42; // Default value
            }
            fclose(input_file);
        }
    } else {
        printf("process %d: Before MPI_Bcast, value is %d\n", rank, value); 
    }

    // each processor calls MPI_Bcast, data is broadcast from root processor and ends up in everyone value variable
    // root process uses MPI_Bcast to broadcast the value, each other process uses MPI_Bcast to receive the broadcast value
    MPI_Bcast(&value, 1, MPI_INT, 0, MPI_COMM_WORLD);

    printf("process %d: After MPI_Bcast, value is %d\n", rank, value);

    MPI_Finalize();

    return 0;
}
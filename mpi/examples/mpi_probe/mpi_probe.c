#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char** argv) {
    int rank, size;
    
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (size < 2) {
        printf("This program requires at least 2 processes.\n");
        MPI_Finalize();
        return 1;
    }

    if (rank == 0) {
        // --- Sender process ---
        srand(time(NULL));
        int count = rand() % 10 + 1; // Send a random number of integers (1 to 10)
        int* data = (int*)malloc(count * sizeof(int));
        for (int i = 0; i < count; i++) {
            data[i] = i * 2;
        }

        printf("Process 0 sending %d integers to Process 1.\n", count);
        MPI_Send(data, count, MPI_INT, 1, 0, MPI_COMM_WORLD);
        
        free(data);

    } else if (rank == 1) {
        // --- Receiver process ---
        MPI_Status status;
        int count;
        
        // Probe for a message from any source with any tag
        printf("Process 1 probing for a message...\n");
        MPI_Probe(MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
        
        // Use the status object to determine the message size
        MPI_Get_count(&status, MPI_INT, &count);

        printf("Process 1 found a message from source %d with tag %d, containing %d integers.\n",
               status.MPI_SOURCE, status.MPI_TAG, count);
        
        // Allocate memory for the incoming message
        int* data = (int*)malloc(count * sizeof(int));

        // Receive the message
        MPI_Recv(data, count, MPI_INT, status.MPI_SOURCE, status.MPI_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        
        printf("Process 1 received the data: ");
        for (int i = 0; i < count; i++) {
            printf("%d ", data[i]);
        }
        printf("\n");
        
        free(data);
    }

    MPI_Finalize();
    return 0;
}


#include <mpi.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    int snd_buf, rcv_buf, sum;
    int right, left;
    int i, my_rank, size;
    MPI_Status status;
    MPI_Request request;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    right = (my_rank + 1) % size;
    left  = (my_rank - 1 + size) % size;
    sum = 0;
    snd_buf = my_rank;

    for (i = 0; i < size; i++) {
        /* Synchronous Issend is used only to demonstrate the use of the
         * nonblocking routine to resolve the deadlock (or serialization)
         * problem. A real application would use standard Isend(). */
        MPI_Issend(&snd_buf, 1, MPI_INT, right, 17, MPI_COMM_WORLD, &request);
        MPI_Recv  (&rcv_buf, 1, MPI_INT, left,  17, MPI_COMM_WORLD, &status);
        MPI_Wait  (&request, &status);
        snd_buf  = rcv_buf;
        sum     += rcv_buf;
    }

    printf("PE%i:\tSum = %i\n", my_rank, sum);

    MPI_Finalize();
    return 0;
}
#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[])
{
  int n;  double result;  // application-related data
  int my_rank, num_procs; // MPI-related data
  FILE *input_file = NULL;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

  if (my_rank == 0)   
  { // reading the application data "n" from file only by process 0:
    input_file = fopen("input.txt", "r");
    if (!input_file) {
      printf("Warning: Could not open input.txt, using default value\n");
      n = 10; // Default value
    } else {
      printf("Enter the number of elements (n): \n");
      if (fscanf(input_file, "%d", &n) == 1) {
        printf("Read value: %d\n", n);
      } else {
        printf("Failed to read from input.txt, using default value\n");
        n = 10; // Default value
      }
      fclose(input_file);
    }
  }
  // broadcasting the content of variable "n" in process 0 
  // into variables "n" in all other processes:
  MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);

  // doing some application work in each process, e.g.:
  result = 1.0 * my_rank * n;
  printf("I am process %i out of %i handling the %ith part of n=%i elements, result=%f \n", 
                       my_rank,  num_procs,      my_rank,       n,                   result );

  if (my_rank != 0)
  { // sending some results from all processes (except 0) to process 0:
    MPI_Send(&result, 1, MPI_DOUBLE, 0, 99, MPI_COMM_WORLD);
  } else
  { // receiving all these messages and, e.g., printing them 
    int rank;
    printf("I'm proc 0: My own result is %f \n", result); 
    for (rank=1; rank<num_procs; rank++)
    {
      MPI_Recv(&result, 1, MPI_DOUBLE, rank, 99, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      printf("I'm proc 0: received result of process %i is %f \n", rank, result); 
    }
  }

  MPI_Finalize();
}

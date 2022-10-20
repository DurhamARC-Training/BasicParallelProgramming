PROGRAM collective
   USE mpi_f08
   implicit none
!   include 'mpif.h'

   integer ierr, rank, size
   integer status (MPI_STATUS_SIZE)
   integer send, recv, token, sum

! Initialise MPI
   CALL MPI_Init(ierr)
   CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierr) ! get size
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! get rank

! Compute global sum of all ranks
   CALL MPI_Allreduce (rank, sum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD, ierr);
   write(*,*) 'Rank ', rank, ': Sum = ', sum

! Compute partial rank sum
   CALL MPI_Scan(rank, sum, 1, MPI_INTEGER, MPI_SUM, MPI_COMM_WORLD)
   write(*,*) 'Rank ', rank, ': Sum = ', sum

   CALL MPI_Finalize(ierr) ! finalise MPI

END PROGRAM collective

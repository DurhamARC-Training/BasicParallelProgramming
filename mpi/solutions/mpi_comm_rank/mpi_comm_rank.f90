PROGRAM mpi_comm_rank_example
   USE mpi_f08
   IMPLICIT NONE

!!!!!!!!!!!!!!!!
!! MPI_Comm_rank
!!!!!!!!!!!!!!!!
!!
!! uses:
!! MPI_Comm_rank(MPI_Comm comm, rank, ierr) 
!!
!! Simple example that outputs the process ID of each process using MPI_Comm_rank
!!
!! example usage:
!!		compile: mpif90 -o mpi_comm_rank mpi_comm_rank.f90
!!		run: mpirun -n 4 mpi_comm_rank
!!

   INTEGER :: rank, ierr

! Turn it into an MPI program (initialise MPI)
   CALL MPI_Init(ierr)
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! sets rank of the current processor, root = 0, to rank variable
   
   WRITE(*,'(A,I0)') 'hello I am process ', rank ! output rank or process ID of this process

! Properly shutdown MPI (finalise MPI)
   CALL MPI_Finalize(ierr)

END PROGRAM mpi_comm_rank_example
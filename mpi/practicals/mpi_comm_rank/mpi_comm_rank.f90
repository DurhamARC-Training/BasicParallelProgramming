PROGRAM mpi_comm_rank_example
!   USE ... !! INSERT MISSING HEADER
   IMPLICIT NONE

!!!!!!!!!!!!!!!!
!! MPI_Comm_rank
!!!!!!!!!!!!!!!!
!!
!! uses:
!! MPI_Comm_rank(MPI_Comm comm, rank, ierr) 
!!
!! int MPI_Comm_rank( MPI_Comm comm, int *rank ) 
!!
!! Simple example that outputs the process ID of each process using MPI_Comm_rank
!!
!! example usage:
!!		compile: mpif90 -o mpi_comm_rank mpi_comm_rank.f90
!!		run: mpirun -n 4 mpi_comm_rank
!!

   INTEGER :: rank, ierr

! Turn it into an MPI program (initialise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE
   ! <-- INSERT MISSING MPI FUNCTION HERE: sets rank of the current processor, root = 0, to rank variable
   
   ! <-- INSERT OUTPUT HERE: output rank or process ID of this process

! Properly shutdown MPI (finalise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

END PROGRAM mpi_comm_rank_example
PROGRAM mpi_abort_example
   USE mpi_f08
   IMPLICIT NONE

!!!!!!!!!!!!
!! MPI_Abort
!!!!!!!!!!!!
!!
!! Simple example that sets up certain number of MPI processes but only continues if 4 processes are used, otherwise
!! use MPI_Abort to properly stop
!!
!! example usage:
!!		compile: mpif90 -o mpi_abort mpi_abort.f90
!!		run: mpirun -n 4 mpi_abort
!!

   INTEGER :: rank, size, ierr

! Turn it into an MPI program (initialise MPI)
   CALL MPI_Init(ierr)
   
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! rank of the processor, root = 0
   CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierr) ! number of processors
   
   IF (size /= 4) THEN
      CALL MPI_Abort(MPI_COMM_WORLD, 1, ierr) ! abort properly with error code '1' if not using 4 processes
   END IF

   WRITE(*,'(A,I0,A,I0)') 'hello I am process: ', rank, ', size should only be 4: ', size

   CALL MPI_Finalize(ierr)

END PROGRAM mpi_abort_example
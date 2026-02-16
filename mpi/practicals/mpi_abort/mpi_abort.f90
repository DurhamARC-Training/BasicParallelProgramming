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
   ! <-- INSERT MISSING MPI FUNCTION HERE
   
   ! <-- INSERT MISSING MPI FUNCTION HERE: rank of the processor, root = 0
   ! <-- INSERT MISSING MPI FUNCTION HERE: number of processors
   
   IF (size /= 4) THEN
      ! <-- INSERT MISSING MPI FUNCTION HERE: abort properly with error code '1' if not using 4 processes
   END IF

   ! <-- INSERT OUTPUT HERE: hello I am process: [rank], size should only be 4: [size]

! Properly shutdown MPI (finalise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

END PROGRAM mpi_abort_example
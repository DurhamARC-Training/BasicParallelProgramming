PROGRAM mpi_abort_example
!   USE mpi_f08
   IMPLICIT NONE

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
PROGRAM mpi_bcast_example
!   USE mpi_f08
   IMPLICIT NONE

   INTEGER :: rank, value, ierr

! Turn it into an MPI program (initialise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

   ! <-- INSERT MISSING MPI FUNCTION HERE: what rank is the current processor

   IF (rank == 0) THEN
      ! if root process we read the value to broadcast
      WRITE(*,*) 'Enter a number to broadcast:'
      read(*,*) value
   ELSE
      WRITE(*,'(A,I0,A,I0)') 'process ', rank, ': Before MPI_Bcast, value is ', value
   END IF

   ! each processor calls MPI_Bcast, data is broadcast from root processor and ends up in everyone value variable
   ! root process uses MPI_Bcast to broadcast the value, each other process uses MPI_Bcast to receive the broadcast value
   ! <-- INSERT MISSING MPI FUNCTION HERE

   WRITE(*,'(A,I0,A,I0)') 'process ', rank, ': After MPI_Bcast, value is ', value

! Properly shutdown MPI (finalise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

END PROGRAM mpi_bcast_example
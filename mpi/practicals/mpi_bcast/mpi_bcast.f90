PROGRAM mpi_bcast_example
!   USE ... !! INSERT MISSING HEADER
   IMPLICIT NONE

!!!!!!!!!!!!
!! MPI_Bcast
!!!!!!!!!!!!
!!
!! uses:
!! MPI_Bcast(buffer, count, datatype, root, comm, ierr)
!!
!! This example simply uses MPI_Bcast to broadcast a read in value to all other processes from root process
!!
!! example usage:
!!		compile: mpif90 -o mpi_bcast mpi_bcast.f90
!!		run: mpirun -n 4 mpi_bcast
!!

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
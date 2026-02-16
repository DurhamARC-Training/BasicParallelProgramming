PROGRAM mpi_isend_example
!   USE ... !! INSERT MISSING HEADER
   IMPLICIT NONE

!!!!!!!!!!!!
!! MPI_Isend
!!!!!!!!!!!!
!!
!! uses:
!! MPI_Isend(buf, count, datatype, dest, tag, comm, request)
!!
!! This example uses MPI_Isend to do a non-blocking send of information from the root process to a destination process.
!! The destination process is set as a variable in the code and must be less than the number of processes started.
!!
!! example usage:
!!		compile: mpif90 -o mpi_isend mpi_isend.f90
!!		run: mpirun -n 4 mpi_isend
!!

   INTEGER :: rank, size, ierr
   INTEGER :: tag, destination, count
   INTEGER :: buffer ! value to send
  TYPE(MPI_Status) :: status
  TYPE(MPI_Request) :: request

   tag = 1234
   destination = 2 ! destination process
   count = 1 ! number of elements in buffer

! Turn it into an MPI program (initialise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE
   ! <-- INSERT MISSING MPI FUNCTION HERE: number of processes
   ! <-- INSERT MISSING MPI FUNCTION HERE: rank of current process

   IF (destination >= size) THEN
      ! <-- INSERT MISSING MPI FUNCTION HERE: destination process must be under the number of processes created, otherwise abort
   END IF

   IF (rank == 0) THEN
      WRITE(*,'(A,I0,A)') 'Enter a value to send to processor ', destination, ':'
      read(*,*) buffer
      ! <-- INSERT MISSING MPI FUNCTION HERE: non blocking send to destination process
   END IF

   IF (rank == destination) THEN
      ! <-- INSERT MISSING MPI FUNCTION HERE: destination process receives
   END IF

   ! <-- INSERT MISSING MPI FUNCTION HERE: blocks and waits for destination process to receive data

   IF (rank == 0) THEN
      WRITE(*,'(A,I0,A,I0)') 'processor ', rank, ' sent ', buffer
   END IF
   IF (rank == destination) THEN
      WRITE(*,'(A,I0,A,I0)') 'processor ', rank, ' got ', buffer
   END IF

! Properly shutdown MPI (finalise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

END PROGRAM mpi_isend_example
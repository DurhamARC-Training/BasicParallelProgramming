PROGRAM mpi_send_example
!   USE mpi_f08
   IMPLICIT NONE

   INTEGER :: rank, value, size, ierr
!   TYPE(MPI_Status) :: status

! Turn it into an MPI program (initialise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE
   
   ! <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process
   ! <-- INSERT MISSING MPI FUNCTION HERE: number of processes that are running

   DO
      IF (rank == 0) THEN
         WRITE(*,*) 'Enter a number to send (input negative to stop):'
         READ(*,*) value
         ! <-- INSERT MISSING MPI FUNCTION HERE: the root process sends the read-in value to next process (by ID)
      ELSE
         ! <-- INSERT MISSING MPI FUNCTION HERE: every process except the root receives the sent value from the previous process ID
         
         IF (rank < size-1) THEN
            ! <-- INSERT MISSING MPI FUNCTION HERE: each process sends the value to the next process by ID
         END IF
      
         ! <-- INSERT OUTPUT HERE: Process [rank] got [value]
      END IF
      
      IF (value < 0) EXIT ! keep going until user inputs negative number
   END DO

! Properly shutdown MPI (finalise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

END PROGRAM mpi_send_example
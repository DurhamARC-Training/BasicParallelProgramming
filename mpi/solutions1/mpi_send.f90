PROGRAM mpi_send_example
   USE mpi_f08
   IMPLICIT NONE

   INTEGER :: rank, value, size, ierr
   TYPE(MPI_Status) :: status

   CALL MPI_Init(ierr)
   
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! get the rank or ID of the current process
   CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierr) ! number of processes that are running

   DO
      IF (rank == 0) THEN
         WRITE(*,*) 'Enter a number to send (input negative to stop):'
         READ(*,*) value
         CALL MPI_Send(value, 1, MPI_INTEGER, rank+1, 0, MPI_COMM_WORLD, ierr) ! the root process sends the read-in value to next process (by ID)
      ELSE
         CALL MPI_Recv(value, 1, MPI_INTEGER, rank-1, 0, MPI_COMM_WORLD, status, ierr) ! every process except the root receives the sent value from the previous process ID
         
         IF (rank < size-1) THEN
            CALL MPI_Send(value, 1, MPI_INTEGER, rank+1, 0, MPI_COMM_WORLD, ierr) ! each process sends the value to the next process by ID
         END IF
      
         WRITE(*,'(A,I0,A,I0)') 'Process ', rank, ' got ', value ! the received value
      END IF
      
      IF (value < 0) EXIT ! keep going until user inputs negative number
   END DO

! Properly shutdown MPI (finalise MPI)
   CALL MPI_Finalize(ierr)

END PROGRAM mpi_send_example
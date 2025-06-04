PROGRAM mpi_send_example
   USE mpi_f08
   IMPLICIT NONE

   INTEGER :: rank, value, size, ierr
   TYPE(MPI_Status) :: status
   INTEGER :: input_unit, io_status

   CALL MPI_Init(ierr)
   
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! get the rank or ID of the current process
   CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierr) ! number of processes that are running

   ! Open input file once at the beginning (only for rank 0)
   IF (rank == 0) THEN
      OPEN(UNIT=10, FILE='input.txt', STATUS='OLD', ACTION='READ', IOSTAT=io_status)
      IF (io_status /= 0) THEN
         WRITE(*,*) 'Warning: Could not open input.txt, will exit immediately'
         input_unit = -1
      ELSE
         input_unit = 10
      END IF
   END IF

   DO
      IF (rank == 0) THEN
         WRITE(*,*) 'Enter a number to send (input negative to stop):'
         IF (input_unit > 0) THEN
            READ(input_unit, *, IOSTAT=io_status) value
            IF (io_status /= 0) THEN
               value = -1  ! Default to exit if file reading fails or EOF
            ELSE
               WRITE(*,'(A,I0)') 'Read value: ', value
            END IF
         ELSE
            value = -1  ! Default to exit if file couldn't be opened
         END IF
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

   ! Close input file at the end
   IF (rank == 0 .AND. input_unit > 0) THEN
      CLOSE(input_unit)
   END IF

! Properly shutdown MPI (finalise MPI)
   CALL MPI_Finalize(ierr)

END PROGRAM mpi_send_example
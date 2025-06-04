PROGRAM mpi_isend_example
   USE mpi_f08
   IMPLICIT NONE

   INTEGER :: rank, size, ierr
   INTEGER :: tag, destination, count
   INTEGER :: buffer ! value to send
   INTEGER :: input_unit, io_status
   TYPE(MPI_Status) :: status
   TYPE(MPI_Request) :: request

   tag = 1234
   destination = 2 ! destination process
   count = 1 ! number of elements in buffer

! Turn it into an MPI program (initialise MPI)
   CALL MPI_Init(ierr)
   
   CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierr) ! number of processes
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! rank of current process

   IF (destination >= size) THEN
      CALL MPI_Abort(MPI_COMM_WORLD, 1, ierr) ! destination process must be under the number of processes created, otherwise abort
   END IF

   IF (rank == 0) THEN
      ! Open input file and read value
      OPEN(UNIT=10, FILE='input.txt', STATUS='OLD', ACTION='READ', IOSTAT=io_status)
      IF (io_status /= 0) THEN
         WRITE(*,*) 'Warning: Could not open input.txt, using default value'
         buffer = 42  ! Default value
      ELSE
         WRITE(*,'(A,I0,A)') 'Enter a value to send to processor ', destination, ':'
         READ(10, *, IOSTAT=io_status) buffer
         IF (io_status /= 0) THEN
            WRITE(*,*) 'Failed to read from input.txt, using default value'
            buffer = 42  ! Default value
         ELSE
            WRITE(*,'(A,I0)') 'Read value: ', buffer
         END IF
         CLOSE(10)
      END IF
      CALL MPI_Isend(buffer, count, MPI_INTEGER, destination, tag, MPI_COMM_WORLD, request, ierr) ! non blocking send to destination process
   END IF

   IF (rank == destination) THEN
      CALL MPI_Irecv(buffer, count, MPI_INTEGER, 0, tag, MPI_COMM_WORLD, request, ierr) ! destination process receives
   END IF

   CALL MPI_Wait(request, status, ierr) ! blocks and waits for destination process to receive data

   IF (rank == 0) THEN
      WRITE(*,'(A,I0,A,I0)') 'processor ', rank, ' sent ', buffer
   END IF
   IF (rank == destination) THEN
      WRITE(*,'(A,I0,A,I0)') 'processor ', rank, ' got ', buffer
   END IF

   CALL MPI_Finalize(ierr)

END PROGRAM mpi_isend_example
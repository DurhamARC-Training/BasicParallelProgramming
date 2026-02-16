PROGRAM mpi_send_example
!   USE "/* INSERT MISSING HEADER */"
   IMPLICIT NONE

!!!!!!!!!!!
!! MPI_Send
!!!!!!!!!!!
!!
!! uses:
!! MPI_Send(buf, count, datatype, dest, tag, MPI_Comm comm)
!!
!! This example sets up a ring of processes, the user gives a value and the root process sends the value
!! to the next process. Each process then sends the value to the next process (by process ID) up to the end of the ring.
!!
!! example usage:
!!		compile: mpif90 -o mpi_send mpi_send.f90
!!		run: mpirun -n 4 mpi_send
!!

   INTEGER :: rank, value, size, ierr
   TYPE(MPI_Status) :: status
   INTEGER :: input_unit, io_status

! Turn it into an MPI program (initialise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE
   ! <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process
   ! <-- INSERT MISSING MPI FUNCTION HERE: number of processes that are running

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

   ! Close input file at the end
   IF (rank == 0 .AND. input_unit > 0) THEN
      CLOSE(input_unit)
   END IF

! Properly shutdown MPI (finalise MPI)
   ! <-- INSERT MISSING MPI FUNCTION HERE

END PROGRAM mpi_send_example
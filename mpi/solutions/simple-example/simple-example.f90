PROGRAM first_example
  USE mpi_f08
  IMPLICIT NONE

  INTEGER :: n               ! application-related data
  DOUBLE PRECISION :: result ! application-related data
  INTEGER :: my_rank, num_procs, rank  ! MPI-related data
  INTEGER :: input_unit, io_status

  CALL MPI_Init()

  CALL MPI_Comm_rank(MPI_COMM_WORLD, my_rank)
  CALL MPI_Comm_size(MPI_COMM_WORLD, num_procs)

  IF (my_rank == 0) THEN  
    !  reading the application data "n" from file only by process 0:
    OPEN(UNIT=10, FILE='input.txt', STATUS='OLD', ACTION='READ', IOSTAT=io_status)
    IF (io_status /= 0) THEN
      WRITE(*,*) "Warning: Could not open input.txt, using default value"
      n = 10  ! Default value
    ELSE
      WRITE(*,*) "Enter the number of elements (n):"
      READ(10, *, IOSTAT=io_status) n
      IF (io_status /= 0) THEN
        WRITE(*,*) "Failed to read from input.txt, using default value"
        n = 10  ! Default value
      ELSE
        WRITE(*,'(A,I0)') "Read value: ", n
      END IF
      CLOSE(10)
    END IF
  ENDIF
  !  broadcasting the content of variable "n" in process 0 
  !  into variables "n" in all other processes:
  CALL MPI_Bcast(n, 1, MPI_INTEGER, 0, MPI_COMM_WORLD)

  !  doing some application work in each process, e.g.:
  result = 1.0 * my_rank * n

  WRITE(*,'(A,I3,A,I3,A,I2,A,I5,A,F9.2)') &
   &        'I am process ', my_rank, ' out of ', num_procs, &
   &        ' handling the ', my_rank, 'th part of n=', n, ' elements, result=', result

  IF (my_rank /= 0) THEN  
    !  sending some results from all processes (except 0) to process 0:
    CALL MPI_Send(result, 1, MPI_DOUBLE_PRECISION, 0, 99, MPI_COMM_WORLD)
  ELSE
    !  receiving all these messages and, e.g., printing them 
    WRITE(*,'(A,F9.2)') &
     &      'I''m proc 0: My own result is ', result
    DO rank=1, num_procs-1
      CALL MPI_Recv(result, 1, MPI_DOUBLE_PRECISION, rank, 99, MPI_COMM_WORLD, MPI_STATUS_IGNORE)
      WRITE(*,'(A,I3,A,F9.2)') &
       &      'I''m proc 0: received result of process ', rank, ' is ', result 
    END DO
  ENDIF

  CALL MPI_Finalize()

END PROGRAM

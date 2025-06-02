PROGRAM mpi_bcast_example
   USE mpi_f08
   IMPLICIT NONE

   INTEGER :: rank, value, ierr

   CALL MPI_Init(ierr)

   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! what rank is the current processor

   IF (rank == 0) THEN
      ! if root process we read the value to broadcast
      WRITE(*,*) 'Enter a number to broadcast:'
      read(*,*) value
   ELSE
      WRITE(*,'(A,I0,A,I0)') 'process ', rank, ': Before MPI_Bcast, value is ', value
   END IF

   ! each processor calls MPI_Bcast, data is broadcast from root processor and ends up in everyone value variable
   ! root process uses MPI_Bcast to broadcast the value, each other process uses MPI_Bcast to receive the broadcast value
   CALL MPI_Bcast(value, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)

   WRITE(*,'(A,I0,A,I0)') 'process ', rank, ': After MPI_Bcast, value is ', value

   CALL MPI_Finalize(ierr)

END PROGRAM mpi_bcast_example
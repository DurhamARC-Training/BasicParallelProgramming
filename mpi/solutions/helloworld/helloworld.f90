PROGRAM helloworld
   USE mpi_f08
   IMPLICIT none
!   include 'mpif.h'

   INTEGER rank, size, ierr
   DOUBLE PRECISION my_data, my_result ! application-related data

! Turn it into an MPI program (need to insert in various locations)
   CALL MPI_INIT(ierr) ! initialise MPI
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank) ! Get rank
   CALL MPI_Comm_size(MPI_COMM_WORLD, size) ! Get size

! Experiment with Hello message in all processes and only in the master process
   WRITE (*,'(A,I3,A,I3)') 'Hello World from ', rank, ' of size ', size
   IF (rank == 0) THEN ! Only rank == 0 should print
      WRITE (*,'(A,I3,A,I3)') 'Hello from rank from the master process ',rank,' of size ', size
   ENDIF

! Print out various information about MPI infrastructure

! Initialize different data in every MPI process depending on their rank

!   my_data = rank + (1.0*rank)/size
!   WRITE(*,'(A,I3,A,I3,A,F9.2)') &
!  & 'I am process ', rank, ' of size ', size, ' with data=', my_data
     
! Broadcast data from some process to all other processes
   !  broadcasting the content of variable "my_data" in process 1
   !  into variables "my_data" in all other processes:
!   CALL MPI_Bcast(my_data, 1, MPI_INTEGER, 1, MPI_COMM_WORLD)

! Do some work with data (get result) and print data and result in every process
!   my_result = 1.0 + my_data
!   WRITE(*,'(A,I3,A,I3,A,F9.2,A,F9.2)') &
!  & 'I am process ', rank, ' of size ', size, ' with data=', my_data, ' and result=', my_result

   CALL MPI_FINALIZE(ierr) ! finalise MPI

END PROGRAM

PROGRAM pingpong
   USE mpi_f08
   implicit none
   include 'mpif.h'

   integer ierr, rank, size, i
   integer status (MPI_STATUS_SIZE)
   integer send, recv

! Initialise MPI
   CALL MPI_Init(ierr)
   CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierr) ! get size
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr) ! get rank

   IF (size.eq.1) THEN
      write (*,*) 'Error: number of processors must be 2 or greater'
      CALL MPI_Finalize(ierr)
      STOP
   END IF

! Initialise data
   send = 0
   recv = 0

   IF (rank.eq.0) send = 1 ! initialise send buffer on the first processor

! Begin loop
   DO i=1,10 ! loop for 10 iterations
      IF (rank.eq.0) then
! Blocking send on first processor to second
         CALL MPI_Ssend(send, 1, MPI_INTEGER, 1, 1, MPI_COMM_WORLD, ierr)
         write(*,*) 'Stage ', 4*(i-1)+1, ': sent ', send, ' on proc ', rank
! Receive message on first processor from second
         CALL MPI_Recv(recv, 1, MPI_INTEGER, 1, 2, MPI_COMM_WORLD, status, ierr)
         write(*,*) 'Stage ', 4*(i-1)+4, ': received ', recv, ' on proc ', rank
         write(*,*)'                     adding 1 to receive buffer and placing in send buffer'
! Alter message for next iteration
         send = recv + 1 
   
      ELSEIF (rank.eq.1) THEN
! Receive on second processor from first
         CALL MPI_Recv(recv, 1, MPI_INTEGER, 0, 1, MPI_COMM_WORLD, status, ierr)
         write(*,*) 'Stage ', 4*(i-1)+2, ': received ', recv, ' on proc ', rank
         write(*,*)'                     adding 1 to recieve buffer and placing in send buffer'
! Alter message to send back again
         send = recv + 1
! Send on second processor back to first
         CALL MPI_Ssend(send, 1, MPI_INTEGER, 0, 2, MPI_COMM_WORLD, ierr)
         write(*,*) 'Stage ', 4*(i-1)+3, ': sent ', send,' on proc ', rank
      ENDIF
      CALL flush(6) ! force output to screen
   END DO
! End loop

   CALL MPI_Finalize(ierr) ! finalise MPI
END program pingpong


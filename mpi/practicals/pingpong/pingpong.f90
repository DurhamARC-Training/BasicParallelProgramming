PROGRAM pingpong
!   USE mpi_f08
   implicit none

   integer ierr, rank, size, i
   integer status (MPI_STATUS_SIZE)
   integer send, recv
   integer, parameter :: N = 2

! Initialise MPI
    ! <-- INSERT initialise MPI here
    ! <-- INSERT get rank of the processor within the global communicator here
    ! <-- INSERT get size of the global communicator here

   IF (size.eq.1) THEN
      write (*,*) 'Error: number of processors must be 2 or greater'
      CALL MPI_Finalize(ierr)
      STOP
   END IF

! Initialise data
   ! <-- INSERT initialise send and recv buffers

! Loop
   DO i=0,N-1 ! loop for N iterations

! Blocking send on first processor to second
      IF (rank.eq.0) then
        ! <-- INSERT Send message from first to second processor
        ! <-- INSERT Receive message on first processor from second
        ! <-- INSERT Alter message for next iteration
   
      ELSEIF (rank.eq.1) THEN
        ! <-- INSERT Receive on second processor from first
        ! <-- INSERT Alter message to send back again
        ! <-- INSERT Send on second processor back to first
   END DO
! End loop

   ! <-- INSERT finalise MPI here

END program pingpong

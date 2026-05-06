program ring
!   use ... !! INSERT MISSING HEADER
	implicit none

!!!!!!!!
!! Ring
!!!!!!!!
!!
!! This example sets up a ring of processes where each process sends a value
!! to the next process and receives a value from the previous process.
!!
!! To avoid deadlock or serialization, use a non-blocking synchronous send.
!!
!! example usage:
!!      compile: mpif90 -o ring ring.f90
!!      run: mpirun -n 4 ring
!!

	integer :: snd_buf, rcv_buf, sum
	integer :: right, left
	integer :: i, my_rank, size
	integer :: ierr
	type(MPI_Status) :: status
	type(MPI_Request) :: request

! Turn it into an MPI program (initialise MPI)
	! <-- INSERT MISSING MPI FUNCTION HERE
	! <-- INSERT MISSING MPI FUNCTION HERE: get the rank or ID of the current process
	! <-- INSERT MISSING MPI FUNCTION HERE: number of processes that are running

	right = mod(my_rank + 1, size)
	left  = mod(my_rank - 1 + size, size)
	sum = 0
	snd_buf = my_rank

	do i = 1, size
		! Synchronous Issend is used only to demonstrate the use of the
		! nonblocking routine to resolve the deadlock (or serialization)
		! problem. A real application would use standard Isend().
		! <-- INSERT MISSING MPI FUNCTION HERE: non-blocking synchronous send to right neighbour
		! <-- INSERT MISSING MPI FUNCTION HERE: receive from left neighbour
		! <-- INSERT MISSING MPI FUNCTION HERE: wait for non-blocking send to complete
		snd_buf = rcv_buf
		sum = sum + rcv_buf
	end do

	write(*,'(A,I0,A,I0)') 'PE', my_rank, ':    Sum = ', sum

! Properly shutdown MPI (finalise MPI)
	! <-- INSERT MISSING MPI FUNCTION HERE

end program ring

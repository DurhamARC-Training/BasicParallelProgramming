program ring
    use mpi
    implicit none

    integer :: snd_buf, rcv_buf, sum
    integer :: right, left
    integer :: i, my_rank, size
    integer :: ierr, request
    integer :: status(MPI_STATUS_SIZE)

    call MPI_Init(ierr)
    call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)

    right = mod(my_rank + 1, size)
    left  = mod(my_rank - 1 + size, size)
    sum = 0
    snd_buf = my_rank

    do i = 1, size
        ! Synchronous Issend is used only to demonstrate the use of the
        ! nonblocking routine to resolve the deadlock (or serialization)
        ! problem. A real application would use standard Isend().
        call MPI_Issend(snd_buf, 1, MPI_INTEGER, right, 17, MPI_COMM_WORLD, request, ierr)
        call MPI_Recv(rcv_buf, 1, MPI_INTEGER, left, 17, MPI_COMM_WORLD, status, ierr)
        call MPI_Wait(request, status, ierr)
        snd_buf = rcv_buf
        sum = sum + rcv_buf
    end do

    print '(A,I0,A,I0)', 'PE', my_rank, ':    Sum = ', sum

    call MPI_Finalize(ierr)
end program ring

PROGRAM pi_mpi
   USE mpi_f08
   IMPLICIT NONE

   INTEGER, PARAMETER :: n = 10000000
   INTEGER :: my_rank, num_procs, ierr
   INTEGER :: i, sub_n, sub_start, num_larger_procs
   DOUBLE PRECISION :: w, x, sum, p_sum, pi
   DOUBLE PRECISION :: wt1, wt2

   CALL MPI_Init(ierr)
   CALL MPI_Comm_size(MPI_COMM_WORLD, num_procs, ierr)
   CALL MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierr)

   ! Calculating the number of elements of my subdomain: sub_n
   ! Calculating the start index sub_start within 0..n-1 
   ! or sub_start = -1 and sub_n = 0 if there is no element

   ! The following algorithm divides 5 into 2 + 1 + 1 + 1
   sub_n = n / num_procs ! = rounding_off(n/num_procs)
   num_larger_procs = n - num_procs*sub_n ! = #procs with sub_n+1 elements
   IF (my_rank < num_larger_procs) THEN
      sub_n = sub_n + 1
      sub_start = my_rank * sub_n
   ELSE IF (sub_n > 0) THEN
      sub_start = num_larger_procs + my_rank * sub_n
   ELSE
      ! this process has only zero elements
      sub_start = -1
      sub_n = 0
   END IF

   wt1 = MPI_Wtime()
 
   ! calculate pi = integral [0..1] 4/(1+x**2) dx
   w = 1.0d0/n
   p_sum = 0.0d0
   DO i = sub_start, sub_start+sub_n-1
      x = w*((DBLE(i))+0.5d0)
      p_sum = p_sum + 4.0d0/(1.0d0+x*x)
   END DO
   
   CALL MPI_Reduce(p_sum, sum, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)

   wt2 = MPI_Wtime()

   WRITE(*,'(A,I0,A,I0,A,I0,A,G12.4,A)') 'PE', my_rank, '/', num_procs, ': sub_n= ', sub_n, ',  wall clock time = ', wt2-wt1, ' sec'

   IF (my_rank == 0) THEN
      pi = w*sum
      WRITE(*,'(A,I0,A,I0,A,G24.16)') 'PE', my_rank, '/', num_procs, ': computed pi = ', pi
      WRITE(*,'(A,G12.4,A)') 'wall clock time = ', wt2-wt1, ' sec'
   END IF

   CALL MPI_Finalize(ierr)

END PROGRAM pi_mpi
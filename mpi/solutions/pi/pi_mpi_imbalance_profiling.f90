PROGRAM pi_mpi_inbalance_profiling
   USE mpi_f08
   IMPLICIT NONE

   INTEGER, PARAMETER :: n = 10000000
   INTEGER :: my_rank, num_procs, ierr
   INTEGER :: i, sub_n, sub_start, num_larger_procs
   DOUBLE PRECISION :: w, x, sum, p_sum, pi
   DOUBLE PRECISION :: wt1, wt2, wt3, wt4
   DOUBLE PRECISION :: wt_numerics, wt_inbalance, wt_comm, wt_total
   DOUBLE PRECISION :: wt_all_numerics, wt_all_inbalance, wt_all_comm, wt_all_total

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
   
   IF (num_procs >= 3) THEN ! in principle, the following inbalance requires only at least 2 processes
                            ! but "3" allows a balanced run with "mpirun -np 2"  :-)
      IF (my_rank == num_procs-2 .AND. sub_start >= 0) THEN
         ! taking all remaining iterations
         sub_n = n - sub_start
      END IF
      IF (my_rank == num_procs-1) THEN
         ! taking zero remaining iterations
         sub_start = -1
         sub_n = 0
      END IF
   END IF

   CALL MPI_Barrier(MPI_COMM_WORLD, ierr) ! for a nearly common start time
   wt1 = MPI_Wtime() ! start time
 
   ! calculate pi = integral [0..1] 4/(1+x**2) dx
   w = 1.0d0/n
   p_sum = 0.0d0
   DO i = sub_start, sub_start+sub_n-1
      x = w*((DBLE(i))+0.5d0)
      p_sum = p_sum + 4.0d0/(1.0d0+x*x)
   END DO

   wt2 = MPI_Wtime() ! after numerics
   CALL MPI_Barrier(MPI_COMM_WORLD, ierr) ! to profile the idle time due to bad load balance
   wt3 = MPI_Wtime() ! before communication

   CALL MPI_Reduce(p_sum, sum, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
   CALL MPI_Barrier(MPI_COMM_WORLD, ierr) ! for a nearly common end time
   wt4 = MPI_Wtime() ! end time
   
   wt_total = wt4 - wt1
   CALL MPI_Reduce(wt_total, wt_all_total, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
   wt_numerics = wt2 - wt1
   CALL MPI_Reduce(wt_numerics, wt_all_numerics, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
   wt_inbalance = wt3 - wt2
   CALL MPI_Reduce(wt_inbalance, wt_all_inbalance, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
   wt_comm = wt4 - wt3
   CALL MPI_Reduce(wt_comm, wt_all_comm, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)

   WRITE(*,'(A,I0,A,I0,A,I7,A,G12.4,A,G12.4,A,G12.4,A,G12.4,A)') &
        'PE', my_rank, '/', num_procs, ': sub_n= ', sub_n, ', ', wt_numerics, ' numerics +  ', &
        wt_inbalance, ' inbalance +  ', wt_comm, ' comm = ', wt_total, ' sec in total'

   CALL MPI_Barrier(MPI_COMM_WORLD, ierr) ! to have some chance to separate output above and below in common stdout
   IF (my_rank == 0) THEN
      pi = w*sum
      WRITE(*,'(A,I0,A,I0,A,G24.16)') 'PE', my_rank, '/', num_procs, ': computed pi = ', pi
      WRITE(*,'(A,I7,A,I0,A,G12.4,A,G12.4,A,G12.4,A,G12.4,A)') &
           'average over all ', num_procs, ' processes: sub_n= ', n/num_procs, ', ', &
           wt_all_numerics/num_procs, ' numerics +  ', wt_all_inbalance/num_procs, &
           ' inbalance +  ', wt_all_comm/num_procs, ' comm = ', wt_all_total/num_procs, ' sec in total'
      WRITE(*,'(A,F6.2,A)') 'Parallel efficiency   = time in numeric  / total time = ', &
           wt_all_numerics /wt_all_total * 100, ' %'
      WRITE(*,'(A,F6.2,A)') 'Loss by inbalance     = time in inbalance/ total time = ', &
           wt_all_inbalance/wt_all_total * 100, ' %'
      WRITE(*,'(A,F6.2,A)') 'Loss by communication = time in comm     / total time = ', &
           wt_all_comm     /wt_all_total * 100, ' %'
   END IF

   CALL MPI_Finalize(ierr)

END PROGRAM pi_mpi_inbalance_profiling
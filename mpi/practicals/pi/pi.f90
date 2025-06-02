PROGRAM pi_serial
   IMPLICIT NONE

   INTEGER, PARAMETER :: n = 10000000
   INTEGER :: i
   DOUBLE PRECISION :: w, x, sum, pi
   DOUBLE PRECISION :: wt1, wt2

   ! Initialize MPI here (when converting to MPI version)
   ! Get rank and size here (when converting to MPI version)
   
   ! For MPI version: Calculate subdomain start and size for each process
   
   wt1 = 0.0  ! Replace with MPI_Wtime() when converting to MPI
 
   ! calculate pi = integral [0..1] 4/(1+x**2) dx
   w = 1.0d0/n
   sum = 0.0d0
   DO i = 0, n-1  ! For MPI version: change loop bounds to subdomain
      x = w*((DBLE(i))+0.5d0)
      sum = sum + 4.0d0/(1.0d0+x*x)
   END DO
   
   ! For MPI version: Add MPI_Reduce here to sum partial results

   wt2 = 0.0  ! Replace with MPI_Wtime() when converting to MPI

   pi = w*sum
   WRITE(*,'(A,G24.16)') 'computed pi = ', pi
   WRITE(*,'(A,G12.4,A)') 'wall clock time = ', wt2-wt1, ' sec'

   ! Finalize MPI here (when converting to MPI version)

END PROGRAM pi_serial
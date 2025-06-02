PROGRAM sumTo10
   USE omp_lib
   IMPLICIT NONE

   INTEGER :: sum, i

   sum = 0
   DO i = 1, 10
      sum = sum + i
   END DO
   WRITE(*,'(A,I0)') 'without multithreading, the sum of first 10 integers is                      ', sum

   sum = 0
   !$OMP PARALLEL DO
   DO i = 1, 10
      sum = sum + i
   END DO
   !$OMP END PARALLEL DO
   WRITE(*,'(A,I0)') 'using unsafe multithreading, the sum of first 10 integers is                 ', sum

   sum = 0
   !$OMP PARALLEL DO
   DO i = 1, 10
      !$OMP CRITICAL
      sum = sum + i   ! one at a time through here
      !$OMP END CRITICAL
   END DO
   !$OMP END PARALLEL DO
   WRITE(*,'(A,I0)') 'using multithreading with "critical" guard, the sum of first 10 integers is  ', sum

   sum = 0
   !$OMP PARALLEL DO REDUCTION(+:sum)
   DO i = 1, 10
      sum = sum + i
   END DO
   !$OMP END PARALLEL DO
   WRITE(*,'(A,I0)') 'using multithreading with reduction, the sum of first 10 integers is         ', sum

END PROGRAM sumTo10
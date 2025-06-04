PROGRAM schedule
   USE omp_lib
   IMPLICIT NONE

   INTEGER :: i

   !$OMP PARALLEL DO
   DO i = 0, 9
      WRITE(*,'(A,I0,A,I0)') 'handling number ', i, ' from thread ', omp_get_thread_num()
   END DO
   !$OMP END PARALLEL DO

   CALL sleep(1)
   WRITE(*,*) 'next with different schedule policy. decided at compile time'
   CALL sleep(1)

   !$OMP PARALLEL DO SCHEDULE(STATIC, 2)
   DO i = 0, 9
      WRITE(*,'(A,I0,A,I0)') 'handling number ', i, ' from thread ', omp_get_thread_num()
   END DO
   !$OMP END PARALLEL DO

END PROGRAM schedule
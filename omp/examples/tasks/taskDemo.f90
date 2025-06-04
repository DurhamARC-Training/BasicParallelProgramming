PROGRAM taskDemo
   USE omp_lib
   IMPLICIT NONE

   DOUBLE PRECISION :: x = 10.0

   WRITE(*,*) 'about to open a parallel region'
   WRITE(*,*) 'waiting for 2 seconds'
   CALL sleep(2)

   !$OMP PARALLEL FIRSTPRIVATE(x)
   WRITE(*,'(A,I0,A)') 'inside parallel region, using thread number ', omp_get_thread_num(), &
                       '. OMP makes no guarantee of ordering'
   CALL sleep(2)

   !$OMP SINGLE
   WRITE(*,*) '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
   WRITE(*,*) 'inside single region. only one thread allowed to do this part'
   WRITE(*,'(A,I0)') 'no guarantee as to which one it is. this time it''s ', omp_get_thread_num()
   WRITE(*,*) 'spawning tasks: '

   !$OMP TASK
   CALL bar()
   !$OMP END TASK

   !$OMP TASK  
   CALL foo()
   !$OMP END TASK

   CALL sleep(3)
   WRITE(*,*) 'notice the order above. we began bar, and then immediately began foo'
   WRITE(*,*) 'we can do the same again, but force bar() to complete before spawning foo'
   WRITE(*,*) '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
   !$OMP END SINGLE

   !$OMP MASTER
   WRITE(*,'(A,I0)') 'this time we use the master thread. it has number ', omp_get_thread_num()
   WRITE(*,*) '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

   !$OMP TASK
   CALL bar()
   !$OMP END TASK

   CALL sleep(1)
   WRITE(*,*) 'waiting for bar to complete before continuing'
   !$OMP TASKWAIT

   !$OMP TASK
   CALL foo()
   !$OMP END TASK
   !$OMP END MASTER

   !$OMP END PARALLEL

CONTAINS

   SUBROUTINE foo()
      USE omp_lib
      WRITE(*,'(A,I0)') 'inside function foo, using thread number ', omp_get_thread_num()
   END SUBROUTINE foo

   SUBROUTINE bar()
      USE omp_lib
      WRITE(*,'(A,I0)') 'inside function bar and sleeping for 2 seconds, using thread number ', &
                        omp_get_thread_num()
      CALL sleep(2)
      WRITE(*,*) 'exiting bar'
   END SUBROUTINE bar

END PROGRAM taskDemo
PROGRAM factorial
   USE omp_lib
   IMPLICIT NONE

   INTEGER :: n

   n = 5

   WRITE(*,'(A,I0,A,I0)') 'factorial of ', n, ' single threaded is: ', factorialSingleThreaded(n)
   WRITE(*,'(A,I0,A,I0)') 'factorial of ', n, ' multi  threaded is: ', factorialMultiThreaded(n)

CONTAINS

   INTEGER FUNCTION factorialSingleThreaded(n)
      INTEGER, INTENT(IN) :: n
      INTEGER :: i

      factorialSingleThreaded = 1
      DO i = 1, n
         factorialSingleThreaded = factorialSingleThreaded * i
      END DO
   END FUNCTION factorialSingleThreaded

   ! implement this!
   INTEGER FUNCTION factorialMultiThreaded(n)
      INTEGER, INTENT(IN) :: n
      
      factorialMultiThreaded = -1
   END FUNCTION factorialMultiThreaded

END PROGRAM factorial
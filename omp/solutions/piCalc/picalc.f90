! we can calculate pi as the integral of 4 / (1 + x^2) from 0 -> 1
! we calculate our integral by evaluating our function at discrete points 
!   along the domain

PROGRAM picalc
   USE omp_lib
   IMPLICIT NONE

   INTEGER, PARAMETER :: nSteps = 10000000

   WRITE(*,'(A,F12.8)') 'integrate single threaded, pi = ', integrateSingleThreaded(0.0D0, 1.0D0, nSteps)
   WRITE(*,'(A,F12.8)') 'integrate multi threaded,  pi = ', integrateMultiThreaded(0.0D0, 1.0D0, nSteps)

CONTAINS

   DOUBLE PRECISION FUNCTION fourOver1px2(x)
      DOUBLE PRECISION, INTENT(IN) :: x
      fourOver1px2 = 4.0D0 / (1.0D0 + x*x)
   END FUNCTION fourOver1px2

   ! nothing too complicated here.
   ! parameters are:
   !   - the lower bound of our integration range
   !   - the upper bound of our integration range  
   !   - the number of steps we take (more steps => more accurate)
   DOUBLE PRECISION FUNCTION integrateSingleThreaded(lower, upper, nSteps)
      DOUBLE PRECISION, INTENT(IN) :: lower, upper
      INTEGER, INTENT(IN) :: nSteps
      DOUBLE PRECISION :: h, xi
      INTEGER :: i

      h = (upper - lower) / nSteps
      integrateSingleThreaded = 0.0D0

      DO i = 0, nSteps-1
         ! set xi to be the lower bound, plus the number of steps we have taken
         xi = lower + i * h
         ! add on the next interpolant
         integrateSingleThreaded = integrateSingleThreaded + fourOver1px2(xi + h/2.0D0) * h
      END DO
   END FUNCTION integrateSingleThreaded

   DOUBLE PRECISION FUNCTION integrateMultiThreaded(lower, upper, nSteps)
      DOUBLE PRECISION, INTENT(IN) :: lower, upper
      INTEGER, INTENT(IN) :: nSteps
      DOUBLE PRECISION :: h, xi
      INTEGER :: i

      h = (upper - lower) / nSteps
      integrateMultiThreaded = 0.0D0

      !$OMP PARALLEL DO DEFAULT(NONE) SHARED(lower, h, nSteps) PRIVATE(xi) REDUCTION(+:integrateMultiThreaded)
      DO i = 0, nSteps-1
         ! set xi to be the lower bound, plus the number of steps we have taken
         xi = lower + i * h
         ! add on the next interpolant
         integrateMultiThreaded = integrateMultiThreaded + fourOver1px2(xi + h/2.0D0) * h
      END DO
      !$OMP END PARALLEL DO
   END FUNCTION integrateMultiThreaded

END PROGRAM picalc
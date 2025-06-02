PROGRAM mandelTask
   USE omp_lib
   IMPLICIT NONE

   INTEGER, PARAMETER :: maxIterations = 500
   DOUBLE PRECISION, PARAMETER :: xStart = -1.0D0
   DOUBLE PRECISION, PARAMETER :: xEnd = 1.0D0
   DOUBLE PRECISION, PARAMETER :: yStart = -1.0D0
   DOUBLE PRECISION, PARAMETER :: yEnd = 1.0D0

   INTEGER, PARAMETER :: numbersToTestInEachDim = 1500
   DOUBLE PRECISION :: xToTest(numbersToTestInEachDim)
   DOUBLE PRECISION :: yToTest(numbersToTestInEachDim)
   LOGICAL :: isMandelOrNot(numbersToTestInEachDim * numbersToTestInEachDim)
   INTEGER :: i, j, totalNumbersTested, totalNumbersInMandel
   DOUBLE PRECISION :: percentage

   !$OMP PARALLEL
   !$OMP SINGLE
   WRITE(*,'(A,I0,A)') 'running with ', omp_get_num_threads(), ' threads'
   !$OMP END SINGLE
   !$OMP END PARALLEL

   CALL populateArray(xToTest, xStart, xEnd, numbersToTestInEachDim)
   CALL populateArray(yToTest, yStart, yEnd, numbersToTestInEachDim)

   ! master region to issue the tasks
   !$OMP PARALLEL
   !$OMP MASTER
   DO i = 1, numbersToTestInEachDim
      DO j = 1, numbersToTestInEachDim
         !$OMP TASK
         isMandelOrNot((i-1) * numbersToTestInEachDim + j) = &
            isMandelBrot(xToTest(i), yToTest(j), maxIterations)
         !$OMP END TASK
      END DO
   END DO
   !$OMP END MASTER
   !$OMP END PARALLEL

   ! traverse the bool array
   totalNumbersTested = numbersToTestInEachDim * numbersToTestInEachDim
   totalNumbersInMandel = 0
   DO i = 1, totalNumbersTested
      IF (isMandelOrNot(i)) totalNumbersInMandel = totalNumbersInMandel + 1
   END DO

   percentage = 100.0D0 * totalNumbersInMandel / totalNumbersTested
   WRITE(*,'(A,I0,A,I0,A,F6.2,A)') 'finished. we tested ', totalNumbersTested, &
                                   ' complex numbers, and ', totalNumbersInMandel, &
                                   ' were mandel numbers. this is ', percentage, ' percent'

CONTAINS

   ! simple function to determine if the complex number x + iy is in the mandelbrot set or not
   LOGICAL FUNCTION isMandelBrot(x, y, maxIters)
      DOUBLE PRECISION, INTENT(IN) :: x, y
      INTEGER, INTENT(IN) :: maxIters
      
      DOUBLE PRECISION :: zR = 0.0D0    ! real part of our variable
      DOUBLE PRECISION :: zI = 0.0D0    ! imaginary part
      INTEGER :: iterator = 0           ! count for number of iterations
      DOUBLE PRECISION :: tempReal

      DO WHILE (iterator < maxIters)
         tempReal = zR
         zR = zR * zR - zI * zI + x
         zI = 2.0D0 * tempReal * zI + y
         iterator = iterator + 1
      END DO

      isMandelBrot = ((zR * zR + zI * zI) < 4.0D0)
   END FUNCTION isMandelBrot

   SUBROUTINE populateArray(array, start, stop, numElements)
      INTEGER, INTENT(IN) :: numElements
      DOUBLE PRECISION, INTENT(OUT) :: array(numElements)
      DOUBLE PRECISION, INTENT(IN) :: start, stop
      DOUBLE PRECISION :: stepSize, arrayElement
      INTEGER :: i

      stepSize = (stop - start) / numElements
      arrayElement = start
      DO i = 1, numElements
         array(i) = arrayElement
         arrayElement = arrayElement + stepSize
      END DO
   END SUBROUTINE populateArray

END PROGRAM mandelTask
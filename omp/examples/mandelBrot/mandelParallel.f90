PROGRAM mandelParallel
   USE omp_lib
   IMPLICIT NONE

   INTEGER, PARAMETER :: maxIterations = 500
   INTEGER :: totalNumbersTested = 0     ! should be 1500 * 1500
   INTEGER :: totalNumbersInMandel = 0

   DOUBLE PRECISION, PARAMETER :: xStart = -1.0D0
   DOUBLE PRECISION, PARAMETER :: xEnd = 1.0D0
   DOUBLE PRECISION, PARAMETER :: yStart = -1.0D0
   DOUBLE PRECISION, PARAMETER :: yEnd = 1.0D0

   INTEGER, PARAMETER :: numbersToTestInEachDim = 1500
   DOUBLE PRECISION :: xToTest(numbersToTestInEachDim)
   DOUBLE PRECISION :: yToTest(numbersToTestInEachDim)
   INTEGER :: i, j
   DOUBLE PRECISION :: percentage
   LOGICAL :: isXYInMandelBrotSet

   !$OMP PARALLEL
   !$OMP SINGLE
   WRITE(*,'(A,I0,A)') 'running with ', omp_get_num_threads(), ' threads'
   !$OMP END SINGLE
   !$OMP END PARALLEL

   CALL populateArray(xToTest, xStart, xEnd, numbersToTestInEachDim)
   CALL populateArray(yToTest, yStart, yEnd, numbersToTestInEachDim)

   DO i = 1, numbersToTestInEachDim
      !$OMP PARALLEL DO REDUCTION(+:totalNumbersTested, totalNumbersInMandel)
      DO j = 1, numbersToTestInEachDim
         ! use our pre-written function to test if this number is in the mandelBrot set or not
         isXYInMandelBrotSet = isMandelBrot(xToTest(i), yToTest(j), maxIterations)
         IF (isXYInMandelBrotSet) totalNumbersInMandel = totalNumbersInMandel + 1
         totalNumbersTested = totalNumbersTested + 1
      END DO
      !$OMP END PARALLEL DO
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

END PROGRAM mandelParallel
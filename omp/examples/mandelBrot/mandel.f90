PROGRAM mandel
   IMPLICIT NONE

   ! let's test numbers from -1 to 1 in each dimension
   INTEGER, PARAMETER :: maxIterations = 500
   INTEGER :: totalNumbersTested = 0     ! should be 1500 * 1500
   INTEGER :: totalNumbersInMandel = 0

   DOUBLE PRECISION, PARAMETER :: xStart = -1.0D0
   DOUBLE PRECISION, PARAMETER :: xEnd = 1.0D0
   DOUBLE PRECISION, PARAMETER :: yStart = -1.0D0
   DOUBLE PRECISION, PARAMETER :: yEnd = 1.0D0

   DOUBLE PRECISION, PARAMETER :: numbersToTestInEachDim = 1500.0D0
   DOUBLE PRECISION :: stepSizeX, stepSizeY
   DOUBLE PRECISION :: x, y
   DOUBLE PRECISION :: percentage
   LOGICAL :: isXYInMandelBrotSet

   stepSizeX = (xEnd - xStart) / numbersToTestInEachDim
   stepSizeY = (yEnd - yStart) / numbersToTestInEachDim

   x = xStart
   DO WHILE (x < xEnd)
      y = yStart
      DO WHILE (y < yEnd)
         isXYInMandelBrotSet = isMandelBrot(x, y, maxIterations)
         IF (isXYInMandelBrotSet) totalNumbersInMandel = totalNumbersInMandel + 1
         totalNumbersTested = totalNumbersTested + 1
         y = y + stepSizeY
      END DO
      x = x + stepSizeX
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

      ! exit condition is either: we reach max iterations or the abs value of our complex number is bigger than 2
      ! every iteration, we send z -> z^2 + x + iy. we start at z = 0
      ! note that (x + iy)^2 = x^2 - y^2 + 2ixy
      ! we update the real part and imaginary part separately
      DO WHILE (iterator < maxIters)
         tempReal = zR    ! store the old value of zR
         zR = zR * zR - zI * zI + x     ! iterate zR
         zI = 2.0D0 * tempReal * zI + y ! iterate zI
         iterator = iterator + 1        ! increment iterator
      END DO

      isMandelBrot = ((zR * zR + zI * zI) < 4.0D0)
   END FUNCTION isMandelBrot

END PROGRAM mandel
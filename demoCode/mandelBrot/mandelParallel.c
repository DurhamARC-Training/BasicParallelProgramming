#include <stdio.h>
#include "mandel.h"
#include <omp.h>

int main(){

  #pragma omp parallel
  {
    #pragma omp single
    printf("running with %d threads\n", omp_get_num_threads());
  }

  //let's test 100 numbers from -1 to 1 in each dimension

  const int maxIterations = 500;

  int totalNumbersTested   = 0; //should be 500 * 500
  int totalNumbersInMandel = 0;

  const double xStart = -1;
  const double xEnd   =  1;
  const double yStart = -1;
  const double yEnd   =  1;

  const int numbersToTestInEachDim = 1500;

  /*
  the compiler is not able to plan ahead when we use floats as our step
  in the for loop. so, we make an array of doubles, which we index
  with an integer. see the implementation in the header file
  */

  double xToTest[numbersToTestInEachDim];
  double yToTest[numbersToTestInEachDim];

  populateArray(xToTest, xStart, xEnd, numbersToTestInEachDim);
  populateArray(yToTest, yStart, yEnd, numbersToTestInEachDim);

  for (int i = 0; i < numbersToTestInEachDim; i++){

    #pragma omp parallel for reduction(+:totalNumbersTested, totalNumbersInMandel)
    for (int j = 0; j < numbersToTestInEachDim; j++){

      //use our pre-written function to test if this number is in the mandelBrot set or not
      bool isXYInMandelBrotSet = isMandelBrot(xToTest[i], yToTest[j], maxIterations);
      if (isXYInMandelBrotSet)
        totalNumbersInMandel++;

      //increment our counter
      totalNumbersTested++;
    }
  }

  double percentage = 100 * totalNumbersInMandel / totalNumbersTested;
  printf("finished. we tested %d complex numbers, and %d were mandel numbers. this is %.2f percent\n", totalNumbersTested, totalNumbersInMandel, percentage);
}
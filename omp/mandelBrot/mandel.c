#include <stdio.h>
#include "mandel.h"

int main(){
  //let's test 100 numbers from -1 to 1 in each dimension

  const int maxIterations = 500;

  int totalNumbersTested   = 0; //should be 500 * 500
  int totalNumbersInMandel = 0;

  double xStart = -1;
  double xEnd   =  1;
  double yStart = -1;
  double yEnd   =  1;

  double numbersToTestInEachDim = 1500;
  double stepSizeX = (xEnd - xStart) / numbersToTestInEachDim;
  double stepSizeY = (yEnd - yStart) / numbersToTestInEachDim;

  for (double x = xStart; x < xEnd; x += stepSizeX){
    for (double y = yStart; y < yEnd; y += stepSizeY){
      bool isXYInMandelBrotSet = isMandelBrot(x,y, maxIterations);
      if (isXYInMandelBrotSet)
        totalNumbersInMandel++;

      //increment our counter
      totalNumbersTested++;
    }
  }

  double percentage = 100 * totalNumbersInMandel / totalNumbersTested;
  printf("finished. we tested %d complex numbers, and %d were mandel numbers. this is %.2f percent\n", totalNumbersTested, totalNumbersInMandel, percentage);
}
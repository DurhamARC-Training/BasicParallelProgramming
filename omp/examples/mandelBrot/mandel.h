#include <stdbool.h>

/*
simple function to determine if the complex number
x + iy is in the mandelbrot set or not
*/

bool isMandelBrot(const double x, const double y, const int maxIters){
  
  //real part of our variable
  double zR = 0;

  //imaginary part
  double zI = 0;

  //count for number of iterations. exit when we exceed maxIters that we pass in
  int iterator = 0;

  /* exit condition is either:
   we reach max iterations or the abs value of our complex number is
   bigger than 2

  every iteration, we send z -> z^2 + x + iy. we start at z = 0

  note that (x + iy)^2 = x^2 - y^2 + 2ixy
  we update the real part and imaginary part separately
  */
  while ( (iterator < maxIters) ){
    //store the old value of zR
    double tempReal = zR;
    
    //iterate zR
    zR = zR * zR - zI * zI + x;

    //iterate zI
    zI = 2 * tempReal * zI + y;

    //increment iterator
    iterator++;
  }

  bool isMandel = ( (zR * zR + zI * zI) < 4 );
  return isMandel;
}

void populateArray(double* array, const double start, const double stop, const double numElements){
  double stepSize     = (stop - start) / numElements;
  double arrayElement = start;
  for (int i = 0; i < numElements; i++, arrayElement += stepSize){
    array[i] = arrayElement;
  }
}

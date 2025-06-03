/*
we can calculate pi as the integral of 4 / (1 + x^2) from 0 -> 1
we calculate our integral by evaluating our function at discrete points 
  along the domain
*/

#include <stdio.h>
#include <omp.h>


double fourOver1px2(double x){
  return 4 / (1 + x*x);
}

/*
nothing too comlicated here.
parameters are:
  - a function pointer, which we use to evaluate at discrete points through the domain
  - the lower bound of our integration range
  - the upper bound of our integration range
  - the number of steps we take (more steps => more accurate)
*/
double integrateSingleThreaded( double (*function)(double), const double lower, const double upper, const size_t nSteps ){
  const double h = ( upper - lower ) / nSteps;
  double output  = 0;

  double xi;

  for( size_t i = 0; i < nSteps; i++ ){

    /*
    set xi to be the lower bound, plus the number of steps
    we have taken
    */
    xi = lower + i * h;

    // add on the next interpolant
    output += function( xi + h/2 ) * h;
  }

  return output;  
}

double integrateMultiThreaded( double (*function)(double), const double lower, const double upper, const size_t nSteps ){
  const double h = ( upper - lower ) / nSteps;
  double output  = 0;

  double xi;

  #pragma omp parallel for default(none) shared(function) private(xi) reduction(+:output)
  for( size_t i = 0; i < nSteps; i++ ){

    /*
    set xi to be the lower bound, plus the number of steps
    we have taken
    */
    xi = lower + i * h;

    // add on the next interpolant
    output += function( xi + h/2 ) * h;
  }

  return output;  
}

int main(){
  printf("integrate single threaded, pi = %f \n", integrateSingleThreaded( &fourOver1px2, 0, 1, 10000000 ));
  printf("integrate multi threaded,  pi = %f \n", integrateMultiThreaded( &fourOver1px2, 0, 1, 10000000 ));
}

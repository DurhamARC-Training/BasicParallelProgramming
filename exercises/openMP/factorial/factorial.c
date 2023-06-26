#include <omp.h>
#include <stdio.h>

int factorialSingleThreaded(int n){
  int output = 1;
  for (int i=1; i<=n; i++){
    output *= i;
  }
  return output;
}

/*
implement this!
*/
int factorialMultiThreaded(int n){
  
  
  return -1;
}

int main(){
  printf("5 factorial single threaded is: %d \n", factorialSingleThreaded(5));
  printf("5 factorial multi  threaded is: %d \n", factorialMultiThreaded(5));
}

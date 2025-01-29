#include <omp.h>
#include <stdio.h>

int factorialSingleThreaded(int n){
  int output = 1;
  for (int i=1; i<=n; i++){
    output *= i;
  }
  return output;
}

int factorialMultiThreaded(int n){
  int output = 1;
  #pragma omp parallel for reduction(*:output)
  for (int i=1; i<=n; i++){
    output *= i;
  }
  return output;
}

int main(){
  printf("5 factorial single threaded is: %d \n", factorialSingleThreaded(5));
  printf("5 factorial multi  threaded is: %d \n", factorialMultiThreaded(5));
}

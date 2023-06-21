#include <stdio.h>
#include <omp.h>

int main(){

  int sum = 0;
  for (int i=1; i<=10; i++){
    sum += i;
  }

  printf("without multithreading, the sum of first 10 integers is %d\n", sum);

  sum = 0;

  #pragma omp parallel for
  for (int i=1; i<=10; i++){
    sum += i;
  }

  printf("using multithreading, the sum of first 10 integers is %d\n", sum);

  sum = 0;

  #pragma omp parallel for
  for (int i=1; i<=10; i++){
    #pragma omp critical //one at a time through here
    sum += i;
  }

  printf("using multithreading with \"critical\" guard, the sum of first 10 integers is %d\n", sum);

  sum = 0;
  
  #pragma omp parallel for reduction(+:sum)
  for (int i=1; i<=10; i++){
    sum += i;
  }

  printf("using multithreading with reduction, the sum of first 10 integers is %d\n", sum);

}
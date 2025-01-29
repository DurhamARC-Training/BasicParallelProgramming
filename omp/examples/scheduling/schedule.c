#include <stdio.h>
#include <unistd.h>
#include <omp.h>

int main(){

  #pragma omp parallel for
  for (int i=0; i < 10; i++){
    printf("handling number %d from thread %d\n", i, omp_get_thread_num());
  }

  sleep(1);
  printf("next with different schedule policy. decided at compile time\n");
  sleep(1);

  #pragma omp parallel for schedule(static, 2)
  for (int i=0; i < 10; i++){
    printf("handling number %d from thread %d\n", i, omp_get_thread_num());
  }

}

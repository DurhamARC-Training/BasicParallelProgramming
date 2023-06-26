#include <omp.h>
#include <stdio.h>
#include <unistd.h>

void foo(){
	printf("inside function foo, using thread number %d\n", omp_get_thread_num());
}

void bar(){
	printf("inside function bar and sleeping for 2 seconds, using thread number %d\n", omp_get_thread_num());
	sleep(2);
  printf("exiting bar\n");
}

int main(){
  printf("about to open a parallel region\n");
  printf("waiting for 2 seconds");
  sleep(2);

  double x = 10;
  // printf("x=%f\n", x);

  #pragma omp parallel firstprivate(x)
  {
    // printf("x=%f\n", x);
    printf("inside parallel region, using thread number %d. OMP makes no guarantee of ordering\n", omp_get_thread_num());
    sleep(2);

    #pragma omp single
    {
      printf("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
      printf("inside single region. only one thread allowed to do this part\n");
      printf("no guarantee as to which one it is. this time it's %d\n", omp_get_thread_num());
      printf("spawning tasks: \n");

      #pragma omp task
      bar();

      #pragma omp task
      foo();

      sleep(3);
      printf("notice the order above. we began bar, and then immediately began foo\n");
      printf("we can do the same again, but force bar() to complete before spawning foo\n");
      printf("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
    }

    #pragma omp master
    {
      printf("this time we use the master thread. it has number %d \n", omp_get_thread_num());
      printf("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");

      #pragma omp task
      bar();

      sleep(1);
      printf("waiting for bar to complete before continuing\n");
      #pragma omp taskwait

      #pragma omp task
      foo();
    }

  }
}

PROGRAM helloworld
   USE mpi_f08
   IMPLICIT none

   DOUBLE PRECISION :: my_data, my_result ! application-related data

! Turn it into an MPI program

! Experiment with Hello message in all processes and only in the master process

   WRITE (*,*) 'Hello World'

! Print out various information about MPI infrastructure

! Initialize different data in every MPI process depending on their rank

   WRITE(*,'(A,F9.2)') &
  & 'I am process ... with data = ', my_data

! Don't do - Broadcast data from some process to all other processes

! Don't do - Do some work with data (get result) and print data and result in every process

END PROGRAM 

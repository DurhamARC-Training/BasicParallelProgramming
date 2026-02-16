PROGRAM helloworld
   USE mpi_f08
   IMPLICIT none

!!!!!!!!!!!!!!!!!!
!! MPI Hello World
!!!!!!!!!!!!!!!!!!
!!
!! Classical example printing "Hello World" in several processes
!!
!! example usage:
!!		compile: mpif90 -o helloworld helloworld.f90
!!		run: mpirun -n 4 helloworld
!!

   DOUBLE PRECISION :: my_data, my_result ! application-related data

! Turn it into an MPI program
   CALL ... ! initialise MPI
   CALL ... ! get rank
   CALL ... ! get size

! Experiment with Hello message in all processes and only in the master process

   WRITE (*,*) ...

   CALL ... ! finalise MPI

END PROGRAM 

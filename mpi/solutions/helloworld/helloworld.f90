PROGRAM helloworld
   USE mpi_f08
   IMPLICIT none
!   include 'mpif.h'

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

   INTEGER :: rank, size, ierr
   DOUBLE PRECISION :: my_data, my_result ! application-related data

! Turn it into an MPI program (need to insert in various locations)
   CALL MPI_INIT(ierr) ! initialise MPI
   CALL MPI_Comm_rank(MPI_COMM_WORLD, rank) ! Get rank
   CALL MPI_Comm_size(MPI_COMM_WORLD, size) ! Get size

! Experiment with Hello message in all processes and only in the master process
   WRITE (*,'(A,I3,A,I3)') 'Hello World from ', rank, ' of size ', size
   IF (rank == 0) THEN ! Only rank == 0 should print
      WRITE (*,'(A,I3,A,I3)') 'Hello from rank from the master process ',rank,' of size ', size
   ENDIF

   CALL MPI_FINALIZE(ierr) ! finalise MPI

END PROGRAM

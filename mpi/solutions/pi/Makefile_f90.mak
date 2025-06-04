export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

pi: pi_mpi.f90
	mpif90 -o pi_intermediate.o -c pi_mpi.f90 $(FFLAGS)
	mpif90 pi_intermediate.o -o pi $(LDFLAGS)
	rm -rf *.o

pi_imbalance: pi_mpi_imbalance.f90
	mpif90 -o pi_imbalance_intermediate.o -c pi_mpi_imbalance.f90 $(FFLAGS)
	mpif90 pi_imbalance_intermediate.o -o pi_imbalance $(LDFLAGS)
	rm -rf *.o

pi_profiling: pi_mpi_imbalance_profiling.f90
	mpif90 -o pi_profiling_intermediate.o -c pi_mpi_imbalance_profiling.f90 $(FFLAGS)
	mpif90 pi_profiling_intermediate.o -o pi_profiling $(LDFLAGS)
	rm -rf *.o

all:
	make pi
	make pi_imbalance
	make pi_profiling

clean:
	rm -rf pi pi_imbalance pi_profiling

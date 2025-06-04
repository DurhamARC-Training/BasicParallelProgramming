export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

pi: pi_mpi.c
	mpicc -o pi_intermediate.o -c pi_mpi.c $(CFLAGS)
	mpicc pi_intermediate.o -o pi $(LDFLAGS)
	rm -rf *.o

pi_imbalance: pi_mpi_imbalance.c
	mpicc -o pi_imbalance_intermediate.o -c pi_mpi_imbalance.c $(CFLAGS)
	mpicc pi_imbalance_intermediate.o -o pi_imbalance $(LDFLAGS)
	rm -rf *.o

pi_profiling: pi_mpi_imbalance_profiling.c
	mpicc -o pi_profiling_intermediate.o -c pi_mpi_imbalance_profiling.c $(CFLAGS)
	mpicc pi_profiling_intermediate.o -o pi_profiling $(LDFLAGS)
	rm -rf *.o

all:
	make pi
	make pi_imbalance
	make pi_profiling

clean:
	rm -rf pi pi_imbalance pi_profiling
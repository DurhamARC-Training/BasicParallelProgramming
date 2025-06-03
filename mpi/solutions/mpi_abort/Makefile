export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

mpi_abort: mpi_abort.c
	mpicc -o mpi_abort_intermediate.o -c mpi_abort.c $(CFLAGS)
	mpicc mpi_abort_intermediate.o -o mpi_abort $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_abort

clean:
	rm -rf mpi_abort
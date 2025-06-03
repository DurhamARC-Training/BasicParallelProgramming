export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

mpi_isend: mpi_isend.c
	mpicc -o mpi_isend_intermediate.o -c mpi_isend.c $(CFLAGS)
	mpicc mpi_isend_intermediate.o -o mpi_isend $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_isend

clean:
	rm -rf mpi_isend
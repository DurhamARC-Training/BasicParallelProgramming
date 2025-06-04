export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

mpi_bcast: mpi_bcast.c
	mpicc -o mpi_bcast_intermediate.o -c mpi_bcast.c $(CFLAGS)
	mpicc mpi_bcast_intermediate.o -o mpi_bcast $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_bcast

clean:
	rm -rf mpi_bcast
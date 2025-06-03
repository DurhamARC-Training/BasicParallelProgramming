export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

mpi_bcast: mpi_bcast.f90
	mpif90 -o mpi_bcast_intermediate.o -c mpi_bcast.f90 $(FFLAGS)
	mpif90 mpi_bcast_intermediate.o -o mpi_bcast $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_bcast

clean:

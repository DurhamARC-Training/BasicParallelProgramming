export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

mpi_abort: mpi_abort.f90
	mpif90 -o mpi_abort_intermediate.o -c mpi_abort.f90 $(FFLAGS)
	mpif90 mpi_abort_intermediate.o -o mpi_abort $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_abort

clean:

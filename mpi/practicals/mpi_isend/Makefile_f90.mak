export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

mpi_isend: mpi_isend.f90
	mpif90 -o mpi_isend_intermediate.o -c mpi_isend.f90 $(FFLAGS)
	mpif90 mpi_isend_intermediate.o -o mpi_isend $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_isend

clean:
	rm -rf mpi_isend

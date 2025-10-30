export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

mpi_probe: mpi_probe.f90
	mpif90 -o mpi_probe_intermediate.o -c mpi_probe.f90 $(FFLAGS)
	mpif90 mpi_probe_intermediate.o -o mpi_probe $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_probe

clean:

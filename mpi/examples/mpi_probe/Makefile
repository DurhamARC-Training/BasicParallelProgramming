export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

mpi_probe: mpi_probe.c
	mpicc -o mpi_probe_intermediate.o -c mpi_probe.c $(CFLAGS)
	mpicc mpi_probe_intermediate.o -o mpi_probe $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_probe

clean:
	rm -rf mpi_probe
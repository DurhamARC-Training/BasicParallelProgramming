export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

mpi_send: mpi_send.f90
	mpif90 -o mpi_send_intermediate.o -c mpi_send.f90 $(FFLAGS)
	mpif90 mpi_send_intermediate.o -o mpi_send $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_send

clean:
	rm -rf mpi_send

export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

mpi_send: mpi_send.c
	mpicc -o mpi_send_intermediate.o -c mpi_send.c $(CFLAGS)
	mpicc mpi_send_intermediate.o -o mpi_send $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_send

clean:
	rm -rf mpi_send
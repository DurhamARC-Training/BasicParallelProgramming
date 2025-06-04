export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

mpi_comm_rank: mpi_comm_rank.c
	mpicc -o mpi_comm_rank_intermediate.o -c mpi_comm_rank.c $(CFLAGS)
	mpicc mpi_comm_rank_intermediate.o -o mpi_comm_rank $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_comm_rank

clean:
	rm -rf mpi_comm_rank
export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

mpi_comm_rank: mpi_comm_rank.f90
	mpif90 -o mpi_comm_rank_intermediate.o -c mpi_comm_rank.f90 $(FFLAGS)
	mpif90 mpi_comm_rank_intermediate.o -o mpi_comm_rank $(LDFLAGS)
	rm -rf *.o

all:
	make mpi_comm_rank

clean:
	rm -rf mpi_comm_rank
